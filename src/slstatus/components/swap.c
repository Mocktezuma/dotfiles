/* See LICENSE file for copyright and license details. */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../util.h"

#if defined(__linux__)
	static int
	get_swap_info(long *s_total, long *s_free, long *s_cached)
	{
		FILE *fp;
		struct {
			const char *name;
			const size_t len;
			long *var;
		} ent[] = {
			{ "SwapTotal",  sizeof("SwapTotal") - 1,  s_total  },
			{ "SwapFree",   sizeof("SwapFree") - 1,   s_free   },
			{ "SwapCached", sizeof("SwapCached") - 1, s_cached },
		};
		size_t line_len = 0, i, left;
		char *line = NULL;

		/* get number of fields we want to extract */
		for (i = 0, left = 0; i < LEN(ent); i++) {
			if (ent[i].var) {
				left++;
			}
		}

		if (!(fp = fopen("/proc/meminfo", "r"))) {
			warn("fopen '/proc/meminfo':");
			return 1;
		}

		/* read file line by line and extract field information */
		while (left > 0 && getline(&line, &line_len, fp) >= 0) {
			for (i = 0; i < LEN(ent); i++) {
				if (ent[i].var &&
				    !strncmp(line, ent[i].name, ent[i].len)) {
					sscanf(line + ent[i].len + 1,
					       "%ld kB\n", ent[i].var);
					left--;
					break;
				}
			}
		}
		free(line);
		if (ferror(fp)) {
			warn("getline '/proc/meminfo':");
			return 1;
		}

		fclose(fp);
		return 0;
	}

	const char *
	swap_free(void)
	{
		long free;

		if (get_swap_info(NULL, &free, NULL)) {
			return NULL;
		}

		return fmt_human(free * 1024, 1024);
	}

	const char *
	swap_perc(void)
	{
		long total, free, cached;

		if (get_swap_info(&total, &free, &cached) || total == 0) {
			return NULL;
		}

		return bprintf("%d", 100 * (total - free - cached) / total);
	}

	const char *
	swap_total(void)
	{
		long total;

		if (get_swap_info(&total, NULL, NULL)) {
			return NULL;
		}

		return fmt_human(total * 1024, 1024);
	}

	const char *
	swap_used(void)
	{
		long total, free, cached;

		if (get_swap_info(&total, &free, &cached)) {
			return NULL;
		}

		return fmt_human((total - free - cached) * 1024, 1024);
	}
#elif defined(__OpenBSD__)
	#include <stdlib.h>
	#include <sys/swap.h>
	#include <sys/types.h>
	#include <unistd.h>

	static int
	getstats(int *total, int *used)
	{
		struct swapent *sep, *fsep;
		int rnswap, nswap, i;

		if ((nswap = swapctl(SWAP_NSWAP, 0, 0)) < 1) {
			warn("swaptctl 'SWAP_NSWAP':");
			return 1;
		}
		if (!(fsep = sep = calloc(nswap, sizeof(*sep)))) {
			warn("calloc 'nswap':");
			return 1;
		}
		if ((rnswap = swapctl(SWAP_STATS, (void *)sep, nswap)) < 0) {
			warn("swapctl 'SWAP_STATA':");
			return 1;
		}
		if (nswap != rnswap) {
			warn("getstats: SWAP_STATS != SWAP_NSWAP");
			return 1;
		}

		*total = 0;
		*used = 0;

		for (i = 0; i < rnswap; i++) {
			*total += sep->se_nblks >> 1;
			*used += sep->se_inuse >> 1;
		}

		free(fsep);

		return 0;
	}

	const char *
	swap_free(void)
	{
		int total, used;

		if (getstats(&total, &used)) {
			return NULL;
		}

		return fmt_human((total - used) * 1024, 1024);
	}

	const char *
	swap_perc(void)
	{
		int total, used;

		if (getstats(&total, &used)) {
			return NULL;
		}

		if (total == 0) {
			return NULL;
		}

		return bprintf("%d", 100 * used / total);
	}

	const char *
	swap_total(void)
	{
		int total, used;

		if (getstats(&total, &used)) {
			return NULL;
		}

		return fmt_human(total * 1024, 1024);
	}

	const char *
	swap_used(void)
	{
		int total, used;

		if (getstats(&total, &used)) {
			return NULL;
		}

		return fmt_human(used * 1024, 1024);
	}
#endif
