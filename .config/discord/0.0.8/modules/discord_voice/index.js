const VoiceEngine = require('./discord_voice.node');
const ChildProcess = require('child_process');
const path = require('path');
const yargs = require('yargs');

const isElectronRenderer =
  typeof window !== 'undefined' && window != null && window.DiscordNative && window.DiscordNative.isRenderer;

const appSettings = isElectronRenderer ? require('electron').remote.getGlobal('appSettings') : global.appSettings;
const features = isElectronRenderer ? require('electron').remote.getGlobal('features') : global.features;
const mainArgv = isElectronRenderer ? require('electron').remote.process.argv : [];
const releaseChannel = isElectronRenderer ? require('electron').remote.getGlobal('releaseChannel') : '';
const modulePath = isElectronRenderer ? require('electron').remote.getGlobal('modulePath') : '';
const useLegacyAudioDevice = appSettings ? appSettings.get('useLegacyAudioDevice') : false;
const defaultSubsystem = 'standard';
const audioSubsystem = useLegacyAudioDevice
  ? 'legacy'
  : appSettings
  ? appSettings.get('audioSubsystem') || defaultSubsystem
  : defaultSubsystem;
const debugLogging = appSettings ? appSettings.get('debugLogging') : false;

const argv = yargs(mainArgv.slice(1))
  .describe('log-level', 'Logging level.')
  .default('log-level', -1)
  .help('h')
  .alias('h', 'help')
  .exitProcess(false).argv;
const logLevel = argv['log-level'];

let voiceModulePath;
if (debugLogging && modulePath) {
  voiceModulePath = path.join(modulePath, 'discord_voice');
}

features.declareSupported('voice_panning');
features.declareSupported('voice_multiple_connections');
features.declareSupported('media_devices');
features.declareSupported('media_video');
features.declareSupported('debug_logging');
features.declareSupported('set_audio_device_by_id');
features.declareSupported('loopback');

if (process.platform === 'win32') {
  features.declareSupported('voice_legacy_subsystem');
  features.declareSupported('soundshare');
}

if (process.platform !== 'linux') {
  features.declareSupported('voice_experimental_subsystem');
}

VoiceEngine.createTransport = VoiceEngine._createTransport;

if (isElectronRenderer) {
  VoiceEngine.setImageDataAllocator((width, height) => new window.ImageData(width, height));
}

VoiceEngine.setAudioSubsystem = function(subsystem) {
  if (appSettings == null) {
    console.warn('Unable to access app settings.');
    return;
  }

  // TODO: With experiment controlling ADM selection, this may be incorrect since
  // audioSubsystem is read from settings (or default if does not exists)
  // and not the actual ADM used.
  if (subsystem === audioSubsystem) {
    return;
  }

  appSettings.set('audioSubsystem', subsystem);
  appSettings.set('useLegacyAudioDevice', false);
  appSettings.save();

  reloadElectronApp();
};

VoiceEngine.setDebugLogging = function(enable) {
  if (appSettings == null) {
    console.warn('Unable to access app settings.');
    return;
  }

  if (debugLogging === enable) {
    return;
  }

  appSettings.set('debugLogging', enable);

  appSettings.save();
  reloadElectronApp();
};

VoiceEngine.getDebugLogging = function() {
  return debugLogging;
};

reloadElectronApp = function() {
  if (isElectronRenderer) {
    const app = require('electron').remote.app;
    app.relaunch();
    app.exit(0);
  } else {
    ChildProcess.spawn(process.argv[0], process.argv.splice(1), {detached: true});
    process.exit(0);
  }
};

console.log(`Initializing voice engine with audio subsystem: ${audioSubsystem}`);
VoiceEngine.initialize({audioSubsystem, voiceModulePath, logLevel});

module.exports = VoiceEngine;
