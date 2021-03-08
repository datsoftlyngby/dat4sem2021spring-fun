{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_day_one (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/AKA/Library/Haskell/bin"
libdir     = "/Users/AKA/Library/Haskell/ghc-8.0.1-x86_64/lib/day-one-0.0.0"
datadir    = "/Users/AKA/Library/Haskell/share/ghc-8.0.1-x86_64/day-one-0.0.0"
libexecdir = "/Users/AKA/Library/Haskell/libexec"
sysconfdir = "/Users/AKA/Library/Haskell/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "day_one_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "day_one_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "day_one_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "day_one_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "day_one_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
