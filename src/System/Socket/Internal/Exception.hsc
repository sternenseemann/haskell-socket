{-# LANGUAGE DeriveDataTypeable, GeneralizedNewtypeDeriving #-}
module System.Socket.Internal.Exception where

import Control.Exception
import Data.Typeable
import Foreign.C.Types

#include "hs_socket.h"

newtype SocketException
      = SocketException CInt
  deriving (Typeable, Eq)

instance Exception SocketException

instance Show SocketException where
  show e@(SocketException i)
    | e == eOK             = "eOK"
    | e == eINTR           = "eINTR"
    | e == eAGAIN          = "eAGAIN"
    | e == eWOULDBLOCK     = "eWOULDBLOCK"
    | e == eBADF           = "eBADF"
    | e == eINPROGRESS     = "eINPROGRESS"
    | e == ePROTONOSUPPORT = "ePROTONOSUPPORT"
    | e == eINVAL          = "eINVAL"
    | e == eCONNREFUSED    = "eCONNREFUSED"
    | otherwise            = "SocketException " ++ show i

eOK         :: SocketException
eOK          = SocketException (#const SEOK)

eINTR       :: SocketException
eINTR        = SocketException (#const SEINTR)

eAGAIN      :: SocketException
eAGAIN       = SocketException (#const SEAGAIN)

eWOULDBLOCK :: SocketException
eWOULDBLOCK  = SocketException (#const SEWOULDBLOCK)

eBADF       :: SocketException
eBADF        = SocketException (#const SEBADF)

eINPROGRESS :: SocketException
eINPROGRESS  = SocketException (#const SEINPROGRESS)

ePROTONOSUPPORT :: SocketException
ePROTONOSUPPORT  = SocketException (#const SEPROTONOSUPPORT)

eINVAL          :: SocketException
eINVAL           = SocketException (#const SEINVAL)

eCONNREFUSED    :: SocketException
eCONNREFUSED     = SocketException (#const SECONNREFUSED)
