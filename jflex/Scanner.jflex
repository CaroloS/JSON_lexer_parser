package Example;

import java_cup.runtime.SymbolFactory;
%%
%cup
%class Scanner
%{
	public Scanner(java.io.InputStream r, SymbolFactory sf){
		this(r);
		this.sf=sf;
	}
	private SymbolFactory sf;
%}
%eofval{
    return sf.newSymbol("EOF",sym.EOF);
%eofval}


/* Regular expressions to specify allowed strings and numbers in JSON */

/* string is any unicode character except \ " and other control characters */
/* control unicode characters from wikipedia control characters page */

valid_chars = [^\u0000-\u001F\u007F\u0080-\u009F\"\\]
hex_digit = [0-9a-fA-F]{4}

/* characters that aren't allowed can be included if escaped */
/* need to double escape in the regex here - to escape the character and escape the backslash */
escaped_chars = \\\" | \\\\ | \\\/ | \\b | \\f | \\n | \\r | \\r | \\t | (\\u{hex_digit})
valid_character = {escaped_chars} | {valid_chars}
string = {valid_character}*

/* numbers can be integer, floating point or scientific notation */
integer = -?(0|[1-9][0-9]*)
frac = ["."][0-9]+
exp = (e|E)("+"|-)[0-9]+
all_numbers = {integer}{frac}?{exp}?

%%

/* Defines the terminal symbol tokens in JSON  */

"," { return sf.newSymbol("Comma",sym.COMMA); }
"[" { return sf.newSymbol("Left Square Bracket",sym.LSQBRACKET); }
"]" { return sf.newSymbol("Right Square Bracket",sym.RSQBRACKET); }
"{" { return sf.newSymbol("Left Brace",sym.LBRACE); }
"}" { return sf.newSymbol("Right Brace",sym.RBRACE); }
":" { return sf.newSymbol("Colon",sym.COLON); }

/* Defines the terminal tokens for values in JSON (boolean/string/number/null)  */

"true"|"false" { return sf.newSymbol("Boolean True", sym.BOOLEAN, new Boolean(yytext()));}
"null" { return sf.newSymbol("Null Symbol", sym.NULL);}
{all_numbers} { return sf.newSymbol("All Numbers",sym.ALLNUMBER, new Double (yytext())); }
\"{string}\" { return sf.newSymbol("Unicode String", sym.STRING, new String(yytext()));}
[ \t\r\n\f] { /* ignore white space. */ }
. { System.err.println("Illegal character: "+yytext()); }
