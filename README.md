# JSON_lexer_parser


<strong>Overview</strong> <br>
A JSON lexer and parser that will take input and check if input is valid JSON based on the official structural specifications (http://json.org/). The main files are: <br>
Scanner.jflex: A lexical generator (scanner) in Jflex  <br>
Parser.cup: A syntax analyser (parser) in CUP 

<strong>Requirements</strong> <br>
Java <br>
ant

<strong>Running</strong> <br>
To run use the following commands: <br>
$ ant clean <br>
$ ant jar <br>
$ java -jar jar/Compiler.jar<br>
then enter your JSON (the output will be a list of the JSON values preceded by 'JSON parsed!' <br>
<br>
Or specify input from a file, for example using the input.test file: <br>
java -jar jar/Compiler.jar input.test 
