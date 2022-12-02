import System.IO
import System.Directory (doesFileExist)
import Data.Char (isSpace)

type Task = (Bool, String)
type TaskList = [Task]

taskFile :: FilePath
taskFile = "TasksDB.txt"

main :: IO ()
main = do
    hSetBuffering stdin LineBuffering
    hSetBuffering stdout NoBuffering
    putStrLn "FProg Task List Manager"
    loop

loop :: IO ()
loop = do
    putStr "> "
    line <- getLine
    if null line
        then loop
        else
            let (cmd, args) = splitCmd line
            in do dispatch cmd args
                  loop

splitCmd :: String -> (String, String)
splitCmd line = (cmd , dropWhile isSpace args)
    where (cmd, args) = break isSpace line

dispatch :: String -> String -> IO ()
dispatch "list" _ = listTasksAction taskFile
dispatch "add" t = addTaskAction taskFile t
dispatch "done" nr = markDoneAction taskFile (read nr)
dispatch _ _ = return ()

listTasksAction :: FilePath -> IO ()
listTasksAction file = do
    tasks <- readTasks file
    putStrLn (concat (showTasks tasks))

showTasks :: TaskList -> [String]
showTasks [] = ["nothing to do"]
showTasks ts = map showTask (numberTasks ts)

showTask :: (Int, Task) -> String
showTask (nr, (done, desc)) = nrStr nr ++ " " ++ doneStr done ++ " " ++ desc ++ "\n"
    where doneStr True = "[X]"
          doneStr False = "[ ]"
          nrStr nr = show nr ++ "."

{-
addTaskAction :: FilePath -> String -> IO ()
addTaskAction file desc = do
    currentTasks <- readTasks file
    let newTasks = addTask desc currentTasks
    writeTasks file newTasks

markDoneAction :: FilePath -> Int -> IO ()
markDoneAction file nr = do
    currentTasks <- readTasks file
    let newTasks = markDoneAction nr currentTasks
    writeTasks file newTasks
-}

modifyTasks :: FilePath -> (TaskList -> TaskList) -> IO ()
modifyTasks file f = do
    currentTasks <- readTasks file
    let newTasks = f currentTasks
    writeTasks file newTasks

addTaskAction :: FilePath -> String -> IO ()
addTaskAction file desc =
    modifyTasks file (addTask desc)

markDoneAction :: FilePath -> Int -> IO ()
markDoneAction file nr =
    modifyTasks file (markDone nr)


-- a

readTasks :: FilePath -> IO TaskList
readTasks file = do
    exists <- doesFileExist file
    if not exists then return []
    else do
        content <- readFile file
        let tasks = if null content then [] else (read content)
        return $! tasks

writeTasks :: FilePath -> TaskList -> IO ()
writeTasks file tasks = writeFile file (show tasks)


-- b

addTask :: String -> TaskList -> TaskList
addTask task tasks = tasks ++ [(False, task)]


-- c

nats :: [Int]
nats = enumerate 0
    where enumerate n = n : enumerate (n+1)

{- Varianten
nats' :: [Int]
nats' = iterate (+1) 0

nats'' = [0..]
-}

numberTasks :: [Task] -> [(Int, Task)]
numberTasks tasks = zip nats tasks


-- d

{-
markDone :: Int -> TaskList -> TaskList
markDone tId tasks = map md (numberTasks tasks)
    where md (nr, (done, desc)) | nr == tId = (True, desc)
                                | otherwise = (done, desc)
-}

markDone :: Int -> TaskList -> TaskList
markDone nr tasks = prefix ++ (True, desc) : rest
    where (prefix, (_, desc) : rest) = splitAt nr tasks

