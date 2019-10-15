module WindowManager where

import qualified Styles as Styles
import qualified Keybindings as Keybindings
import qualified Layouts as Layouts
import qualified Logging as Logging
import qualified Mousebindings as Mousebindings
import qualified NixConfig as NixConfig
import qualified WindowRules as WindowRules
import qualified Workspaces as Workspaces
import qualified XMonad as XMonad
import qualified XMonad.Actions.Navigation2D as Navigation2D
import qualified XMonad.Hooks.EwmhDesktops as EwmhDesktops
import qualified XMonad.Hooks.ManageDocks as ManageDocks
import qualified XMonad.Util.Run as Run

start nixConfig = startXmobar nixConfig >>= startXmonad nixConfig

startXmobar nixConfig = Run.spawnPipe $ NixConfig.xmobar $ NixConfig.paths nixConfig

startXmonad nixConfig statusbarPipe =
  XMonad.xmonad $ wmPlugins $ XMonad.def
  { XMonad.workspaces = Workspaces.workspaceNames
  , XMonad.borderWidth = Styles.borderWidth
  , XMonad.normalBorderColor = Styles.normalBorderColor
  , XMonad.focusedBorderColor = Styles.focusedBorderColor
  , XMonad.keys = Keybindings.keybindings nixConfig
  , XMonad.mouseBindings = Mousebindings.mousebindings
  , XMonad.layoutHook = Layouts.layoutHook nixConfig
  , XMonad.manageHook = WindowRules.windowRules
  , XMonad.logHook = Logging.logHook statusbarPipe
  }

-- WM-level plugins
wmPlugins
  = ManageDocks.docks -- Make the status bar work well
  . EwmhDesktops.ewmh -- Implement EWMH for workspace support, xdotool, etc.

  -- Enable directional navigation
  . Navigation2D.withNavigation2DConfig Navigation2D.def
    { Navigation2D.defaultTiledNavigation = Navigation2D.centerNavigation
    }
