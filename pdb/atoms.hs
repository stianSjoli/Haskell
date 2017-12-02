import qualified Data.String.Utils as Str
import Network.HTTP

main :: IO ()

extract :: String -> [String] -> String

pdbEntries::IO String

extract idx content = unlines $ filter (Str.startswith idx) content

atoms = extract "ATOM"

seqres = extract "SEQRES"

pdbEntries = simpleHTTP queryPhrase >>= getResponseBody
			where queryPhrase = getRequest "http://www.rcsb.org/pdb/rest/getCurrent" 

main = do
	pdbEntries >>= putStrLn
	content <- readFile "test.pdb"
  	putStrLn . atoms $ lines content
  	putStrLn . seqres $ lines content