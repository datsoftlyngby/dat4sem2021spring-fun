{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_hello_haskell (
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

bindir     = "/Users/AKA/DatSoftLyngby/dat4sem2021spring-fun/haskell/hello-haskell/.cabal-sandbox/bin"
libdir     = "/Users/AKA/DatSoftLyngby/dat4sem2021spring-fun/haskell/hello-haskell/.cabal-sandbox/lib/x86_64-osx-ghc-8.0.1/hello-haskell-0.0.0-GcfUlA7OBG5GD1Jqqx7DCD"
datadir    = "/Users/AKA/DatSoftLyngby/dat4sem2021spring-fun/haskell/hello-haskell/.cabal-sandbox/share/x86_64-osx-ghc-8.0.1/hello-haskell-0.0.0"
libexecdir = "/Users/AKA/DatSoftLyngby/dat4sem2021spring-fun/haskell/hello-haskell/.cabal-sandbox/libexec"
sysconfdir = "/Users/AKA/DatSoftLyngby/dat4sem2021spring-fun/haskell/hello-haskell/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hello_haskell_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hello_haskell_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "hello_haskell_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hello_haskell_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hello_haskell_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
