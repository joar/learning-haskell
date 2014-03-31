import Network.Socket
import Control.Monad

main :: IO ()
main = do
  -- accept one connection and handle it
  sock <- socket AF_INET Stream 0
  setSocketOption sock ReuseAddr 1
  -- listen on TCP port 4242
  bindSocket sock (SockAddrInet 4242 iNADDR_ANY)
  -- allow a maximum of 2 outstanding connections
  listen sock 2
  mainLoop sock

mainLoop :: Socket -> IO ()
mainLoop sock = forever $ do
  conn <- accept sock
  runConn conn

runConn :: (Socket, SockAddr) -> IO ()
runConn (sock, _) = do
  send sock "Hi!\n"
  sClose sock
