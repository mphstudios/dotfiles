// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {

    // terminal background color
    backgroundColor: 'rgba(0,0,0,0.9)',

    // set to false for no bell
    bell: false,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // border color (window, tabs)
    borderColor: '#333',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#000000',
      red: '#ff0000',
      green: '#33ff00',
      yellow: '#ffff00',
      blue: '#0066ff',
      magenta: '#cc00ff',
      cyan: '#00ffff',
      white: '#d0d0d0',
      lightBlack: '#808080',
      lightRed: '#ff0000',
      lightGreen: '#33ff00',
      lightYellow: '#ffff00',
      lightBlue: '#0066ff',
      lightMagenta: '#cc00ff',
      lightCyan: '#00ffff',
      lightWhite: '#ffffff'
    },

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // custom css to embed in the main window
    css: '',

    // text color under BLOCK cursor
    cursorAccentColor: '#000',

    // set to true for blinking cursor
    cursorBlink: true,

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: 'rgba(248,28,229,0.8)',

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BLOCK',

    // for environment variables
    env: {},

    // color of the text
    foregroundColor: '#fff',

    // font family with optional fallbacks
    fontFamily: "Office Code Pro D, Source Code Pro Light, Menlo, DejaVu Sans Mono, Consolas, Lucida Console, monospace",

    // default font size in pixels for all tabs
    fontSize: 16,

    // default font weight
    fontWeight: 'normal',

    // default font weight for bold characters
    fontWeightBold: 'normal',

    hyperBorder: {
      animate: {
        duration: '3s', // default is 16s
      },
      borderColors: ['#fc1da7', '#fba506'],
      borderRadiusInner: '6px',
      borderRadiusOuter: '6px',
      borderWidth: '1px'
    },

    hyperCwd: {
      initialWorkingDirectory: '~/Code'
    },

    hyperStatusLine: {
      aheadColor: 'ivory',
      dirtyColor: 'salmon',
      footerTransparent: true,
    },

    hyperTabs: {
      activityPulse: true,
      border: true,
      closeAlign: 'right',
      tabIcons: true,
      tabIconsColored: true,
      trafficButtons: true,
    },

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '12px 14px',

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '/usr/local/bin/zsh',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // set to `true` (without backticks) if you're using a Linux setup that doesn't show native menus
    // default: `false` on Linux, `true` on Windows (ignored on macOS)
    showHamburgerMenu: '',

    // set to `false` if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` on windows and Linux (ignored on macOS)
    showWindowControls: true,

    // custom css to embed in the terminal window
    termCSS: '',

    // Choose either "stable" for receiving highly polished,
    // or "canary" for less polished but more frequent updates
    updateChannel: 'stable'
  },

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
  },

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [
    //"hyper-statusline"
  ],

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'hyper-dracula',
    'hyper-opacity',
    'hyper-pane',
    'hyper-statusline',
    'hyper-tabs-enhanced',
    'hyper-visual-bell',
    'hyperborder',
    'hypercwd',
    'hyperterm-bold-tab'
  ],
};
