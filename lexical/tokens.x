{
module Main (main) where
}

%wrapper "basic"

$digit = 0-9      -- digits
$alpha = [a-zA-Z]   -- alphabetic characters

tokens :-

  $white+                                ;
  "--".*                                 ;
  program                                { \s -> Program }
  "{"                                    { \s -> Begin}
  "}"                                    { \s -> End}
  ";"                                    { \s -> SemiColon}
  int                                    { \s -> Type s}
  float                                  { \s -> Type s}
  bool                                   { \s -> Type s}
  =                                      { \s -> Assign}
 "("				                             { \s -> BeginParenthesis}
  ")"				                             { \s -> EndParenthesis}
  "["                                    { \s -> BeginIndex}
  "]"                                    { \s -> EndIndex}
  if                                     { \s -> If}
  else                                   { \s -> Else}
  print                                  { \s -> Print}
  while                                  { \s -> While}
  func                                   { \s -> Func}
  >                                      { \s -> Greater}
  "<"                                    { \s -> Less}
  ">="                                   { \s -> GreaterOrEqual}
  "<="                                   { \s -> LessOrEqual}
  "=="                                   { \s -> Equal}
  "!="                                   { \s -> Diff}
  "+"                                    { \s -> Sum}
  "+="                                   { \s -> Increment}
  "-="                                   { \s -> Decrement}
  "-"                                    { \s -> Sub}
  "*"                                    { \s -> Multi}
  "%"                                    { \s -> Mod}
  "^"                                    { \s -> Pow}
  "/"                                    { \s -> Div}
  for                                    { \s -> For}
  $digit+                                { \s -> Int (read s)} 
  $digit+.$digit+                        { \s -> Float (read s)}
  $alpha+[$alpha $digit \_ \']*          { \s -> Id s }
  \" $alpha [$alpha $digit ! \_ \']* \"  { \s -> String s}
{
-- Each action has type :: String -> Token

-- The token type:
data Token =
  Program |
  Begin   |
  End     |
  BeginParenthesis |
  EndParenthesis |
  SemiColon |
  Assign    | 
  If  |
  Else |
  Print |
  Greater |
  BeginIndex|
  EndIndex|
  Increment |
  Decrement|
  GreaterOrEqual |
  Less|
  LessOrEqual |
  Equal |
  Diff |
  Sum |
  Sub|
  Div|
  Mod|
  Multi|
  Pow|
  For|
  While|
  Func|
  Type String |
  Id String |
  Array String|
  Int Int |
  Float Float|
  Bool Bool |
  String String
  deriving (Eq,Show)

main = do
  s <- getContents
  print (alexScanTokens s)
}
