%{
	#define _CRT_SECURE_NO_WARNINGS
	using namespace std;
	#include <iostream>
	#include <stdio.h>
	#include <string.h>
    #include <climits>
    #include <cfloat>
	#include <stack>
	#include <map>

	extern FILE* yyin;
	int yylex();
	int yyerror(const char *msg);
	void executeScriptFile(const char* filename);
    void executeCommand(char* command);

    int isCorected = 1;
	char msg[500];

	/*struct Scope
	{
		map<string, double> localVars;
	};
	stack<Scope> scopeStack;*/

	class TVAR
	{
	    char* nume;
	    double valoare;
	    TVAR* next;
		int tip; //1-int, 2-float, 3-double
	  
	  public:
	     static TVAR* head;
	     static TVAR* tail;

	     TVAR(char* n, double v = 0);
	     TVAR();
	     int findVar(char* n);
         void addVar(char* n, double v = 0);
         double getValue(char* n);
	     void setValue(char* n, double v);
		 void printVars();
		 void setTipVar(char*n,int tip);
		 int getTipVar(char* n);

         bool inInterval(int nr);
		 bool inInterval(double nr);
		 bool inInterval(float nr);

	};

	TVAR* TVAR::head;
	TVAR* TVAR::tail;

	/*void enterScope()
	{
		scopeStack.push(Scope());
	}

	void exitScope()
	{
		if(!scopeStack.empty())
		{
			scopeStack.pop();
		}
	}

	void addLocalVar(const string& name, double value) {
		if (!scopeStack.empty()) {
			scopeStack.top().localVars[name] = value;
		}
	}

	void updateLocalVar(const string& name, double value) {
    stack<Scope> tempStack = scopeStack;
    while (!tempStack.empty()) {
        if (tempStack.top().localVars.find(name) != tempStack.top().localVars.end()) {
            tempStack.top().localVars[name] = value; // Actualizează valoarea
            cout << "Variable '" << name << "' updated to value: " << value << endl;
            return;
        }
        tempStack.pop();
    }
    cout << "Error: Variable '" << name << "' not found in any scope." << endl;
	}


	bool findLocalVar(const string& name) {
		stack<Scope> tempStack = scopeStack;
		while (!tempStack.empty()) {
			if (tempStack.top().localVars.find(name) != tempStack.top().localVars.end()) {
				return true;
			}
			tempStack.pop();
		}
		return false;
	}

	double getLocalVarValue(const string& name) {
		stack<Scope> tempStack = scopeStack;
		while (!tempStack.empty()) {
			if (tempStack.top().localVars.find(name) != tempStack.top().localVars.end()) {
				return tempStack.top().localVars[name];
			}
			tempStack.pop();
		}
		return -1;
	}*/

	TVAR::TVAR(char* n, double v)
	{
		this->nume = new char[strlen(n)+1];
		strcpy(this->nume,n);
		this->valoare = v;
		this->next = NULL;
	}

	TVAR::TVAR()
	{
		TVAR::head = NULL;
		TVAR::tail = NULL;
	}

	int TVAR::findVar(char* n)
	{
		TVAR* tmp = TVAR::head;
		while(tmp != NULL) 
		{ 
			if(strcmp(tmp->nume,n) == 0)
	      		return 1;
        	tmp = tmp->next;
	  	}
	  	return 0;
	}

    void TVAR::addVar(char* n, double v)
	{
		TVAR* elem = new TVAR(n, v);
		if(head == NULL)
		{ 
			TVAR::head = TVAR::tail = elem;
		}
		else 
		{
			TVAR::tail->next = elem;
			TVAR::tail = elem;
		}
	}

    double TVAR::getValue(char* n)
	{
		TVAR* tmp = TVAR::head;
		while(tmp != NULL)
		{
			if(strcmp(tmp->nume,n) == 0)
				return tmp->valoare;
	     	tmp = tmp->next;
	    }
		return -1;
	}

	void TVAR::setValue(char* n, double v)
	{
		TVAR* tmp = TVAR::head;
	    while(tmp != NULL)
	    {
			if(strcmp(tmp->nume,n) == 0)
			{
				tmp->valoare = v;
			}
			tmp = tmp->next;
	    }
	}

	void TVAR::setTipVar(char* n,int tip)
	{
		TVAR* tmp = TVAR::head;
	    while(tmp != NULL)
	    {
			if(strcmp(tmp->nume,n) == 0)
			{
				tmp->tip = tip;
			}
			tmp = tmp->next;
	    }
	}
	int TVAR::getTipVar(char* n)
	{
		TVAR* tmp = TVAR::head;
		while(tmp != NULL)
		{
			if(strcmp(tmp->nume,n) == 0)
				return tmp->tip;
	     	tmp = tmp->next;
	    }
		return -1;
	}

	void TVAR::printVars()
	{
		cout<<"\nPrinting table of variables...\n";
		TVAR* tmp = TVAR::head;
		while(tmp != NULL)
		{
			cout<<tmp->nume<<"=";
			if(tmp->tip==2)
			{
				cout<<tmp->valoare<<"f\n";
			}
			else
			{
				cout<<tmp->valoare<<"\n";
			}
			tmp = tmp->next;
		}	  
	}

    bool TVAR::inInterval(int nr)
	{
		if (nr > INT_MIN && nr < INT_MAX)
			return true;
		return false;
	}

	bool TVAR::inInterval(double nr)
	{
		if (nr > DBL_MIN && nr < DBL_MAX)
			return true;
		return false;
	}

	bool TVAR::inInterval(float nr)
	{
		if (nr > FLT_MIN && nr < FLT_MAX)
			return true;
		return false;
	}

	TVAR* ts = NULL;
%}



%union 
{ 
    char* sir; 
    double doubleVal; 
    int intVal; 
    float floatVal; 
}

%token TOK_PLUS TOK_MINUS TOK_MULT TOK_DIV TOK_LEFTP TOK_RIGHTP TOK_LEFTBP TOK_RIGHTBP TOK_DECLARE_VAR TOK_INT TOK_FLOAT TOK_DOUBLE
%token TOK_SEP TOK_ASSIGN TOK_SCAN TOK_PRINT TOK_ERROR
%token TOK_EQ TOK_NEQ TOK_GT TOK_GTE TOK_LT TOK_LTE
%token TOK_IF TOK_ELSE
%token <doubleVal> VAR_INT 
%token <doubleVal> VAR_FLOAT
%token <doubleVal> VAR_DOUBLE
%token <sir> TOK_IDENTIFIER
%token <sir> TOK_STRING

%type <intVal> CAST_INT
%type <floatVal> CAST_FLOAT
%type <doubleVal> CAST_DOUBLE


%type <doubleVal> E
%type <intVal> CONDITION

%start S

%left TOK_PLUS TOK_MINUS
%left TOK_MULT TOK_DIV



%%
S : 
    | INSTRUCTIONS TOK_SEP S
	//| BLOC_COD
	| BLOCK TOK_SEP S
    | IF_ELSE
    | TOK_ERROR { isCorected = 0; }
    ;
/*BLOC_COD : 
		TOK_LEFTBP 
		 {
			enterScope();
		 } INS_LIST TOK_RIGHTBP{
			exitScope();
		 }
		 ;
INS_LIST:
    INS
    | INS INS_LIST
    ;
INS:
    TOK_DECLARE_VAR TOK_IDENTIFIER TOK_ASSIGN E {
        if (findLocalVar($2)) {
            printf("Variable '%s' already declared in this scope.\n", $2);
        } else {
            addLocalVar($2, $4);
        }
    }
    | TOK_PRINT TOK_IDENTIFIER {
        if (findLocalVar($2)) {
            printf("%s = %f\n", $2, getLocalVarValue($2));
        } else {
            printf("Variable '%s' not declared.\n", $2);
        }
    }
    | TOK_SCAN TOK_IDENTIFIER {
        if (findLocalVar($2)) {
            double value;
            printf("Enter value for %s: ", $2);
            scanf("%lf", &value);
            updateLocalVar($2, value);
        } else {
            printf("Variable '%s' not declared.\n", $2);
        }
    }
    | CONDITION {
        printf("Evaluated condition: %d\n", $1);
    }
    | IF_ELSE
    ;*/

INSTRUCTIONS : TOK_IDENTIFIER TOK_ASSIGN E
    {
		if(ts != NULL)
		{
			if(ts->findVar($1) == 1)
			{
				ts->setValue($1, $3);
			}
			else 
			{
				sprintf(msg,"%d:%d Eroare semantica: Variabila %s este utilizata fara sa fi fost declarata!\n", @1.first_line, @1.first_column, $1);
	    		yyerror(msg);
	    		YYERROR;
	  		}
		}
		else
		{
	  		sprintf(msg,"%d:%d Eroare semantica: Variabila %s este utilizata fara sa fi fost declarata!\n", @1.first_line, @1.first_column, $1);
	  		yyerror(msg);
	  		YYERROR;
		}
    }
	| TOK_INT TOK_IDENTIFIER TOK_ASSIGN E 
	{
		if(ts != NULL)
		{
			if(ts->findVar($2)==0)
			{
				ts->addVar($2);
				ts->setTipVar($2,1);
				ts->setValue($2,$4);
				printf("A fost declarata variabila %s de tipul int si initializata cu valoarea: %lf\n",$2,ts->getValue($2));
			}
			else
			{
				sprintf(msg,"%d:%d Eroare semantica: Declaratii multiple pentru variabila %s!\n", @1.first_line, @1.first_column, $2);
				yyerror(msg);
				YYERROR;
			}
		}
		else
		{
			ts = new TVAR();
			ts->addVar($2);
			ts->setTipVar($2,1);
			ts->setValue($2,$4);
			printf("A fost declarata variabila %s de tipul int si initializata cu valoarea: %lf\n",$2,ts->getValue($2));
		}
	}
    | TOK_INT TOK_IDENTIFIER
    {
		if(ts != NULL)
		{
			if(ts->findVar($2) == 0)
			{
				ts->addVar($2);
				ts->setTipVar($2,1);
				printf("A fost declarata variabila %s de tipul int\n",$2);
			}
			else
			{
				sprintf(msg,"%d:%d Eroare semantica: Declaratii multiple pentru variabila %s!\n", @1.first_line, @1.first_column, $2);
				yyerror(msg);
				YYERROR;
			}
		}
		else
		{
			ts = new TVAR();
			ts->addVar($2);
			ts->setTipVar($2,1);
			printf("A fost declarata variabila %s de tipul int\n",$2);
		}
    }
	| TOK_FLOAT TOK_IDENTIFIER TOK_ASSIGN E 
	{
		if(ts != NULL)
		{
			if(ts->findVar($2)==0)
			{
				ts->addVar($2);
				ts->setTipVar($2,2);
				ts->setValue($2,$4);
				printf("A fost declarata variabila %s de tipul float si initializata cu valoarea: %ff\n",$2,ts->getValue($2));
			}
			else
			{
				sprintf(msg,"%d:%d Eroare semantica: Declaratii multiple pentru variabila %s!\n", @1.first_line, @1.first_column, $2);
				yyerror(msg);
				YYERROR;
			}
		}
		else
		{
			ts = new TVAR();
			ts->addVar($2);
			ts->setTipVar($2,2);
			ts->setValue($2,$4);
			printf("A fost declarata variabila %s de tipul float si initializata cu valoarea: %ff\n",$2,ts->getValue($2));
		}
	}
	| TOK_FLOAT TOK_IDENTIFIER
    {
		if(ts != NULL)
		{
			if(ts->findVar($2) == 0)
			{
				ts->addVar($2);
				ts->setTipVar($2,2);
				printf("A fost declarata variabila %s de tipul float\n",$2);
			}
			else
			{
				sprintf(msg,"%d:%d Eroare semantica: Declaratii multiple pentru variabila %s!\n", @1.first_line, @1.first_column, $2);
				yyerror(msg);
				YYERROR;
			}
		}
		else
		{
			ts = new TVAR();
			ts->addVar($2);
			ts->setTipVar($2,2);
			printf("A fost declarata variabila %s de tipul float\n",$2);
		}
    }
	| TOK_DOUBLE TOK_IDENTIFIER TOK_ASSIGN E 
	{
		if(ts != NULL)
		{
			if(ts->findVar($2)==0)
			{
				ts->addVar($2);
				ts->setTipVar($2,3);
				ts->setValue($2,$4);
				printf("A fost declarata variabila %s de tipul double si initializata cu valoarea: %lf\n",$2,ts->getValue($2));
			}
			else
			{
				sprintf(msg,"%d:%d Eroare semantica: Declaratii multiple pentru variabila %s!\n", @1.first_line, @1.first_column, $2);
				yyerror(msg);
				YYERROR;
			}
		}
		else
		{
			ts = new TVAR();
			ts->addVar($2);
			ts->setTipVar($2,3);
			ts->setValue($2,$4);
			printf("A fost declarata variabila %s de tipul double si initializata cu valoarea: %lf\n",$2,ts->getValue($2));
		}
	}
	| TOK_DOUBLE TOK_IDENTIFIER
    {
		if(ts != NULL)
		{
			if(ts->findVar($2) == 0)
			{
				ts->addVar($2);
				ts->setTipVar($2,3);
				printf("A fost declarata variabila %s de tipul double\n",$2);
			}
			else
			{
				sprintf(msg,"%d:%d Eroare semantica: Declaratii multiple pentru variabila %s!\n", @1.first_line, @1.first_column, $2);
				yyerror(msg);
				YYERROR;
			}
		}
		else
		{
			ts = new TVAR();
			ts->addVar($2);
			ts->setTipVar($2,3);
			printf("A fost declarata variabila %s de tipul double\n",$2);
		}
    }
    | TOK_PRINT TOK_IDENTIFIER
    {
		if(ts != NULL)
		{
			if(ts->findVar($2) == 1)
			{
				if(ts->getValue($2) == -1)
				{
					sprintf(msg,"%d:%d Eroare semantica: Variabila %s este utilizata fara sa fi fost initializata!\n", @1.first_line, @1.first_column, $2);
					yyerror(msg);
					YYERROR;
				}
				else
				{
					if(ts->getTipVar($2)==1)
					{
						printf("%lld\n",(long long int)ts->getValue($2));
					}
					if(ts->getTipVar($2)==2)
					{
						printf("%ff\n",(float)ts->getValue($2));
					}
					if(ts->getTipVar($2)==3)
					{
						printf("%lf\n",ts->getValue($2));
					}
				}
	  		}
	  		else
	  		{
				sprintf(msg,"%d:%d Eroare semantica: Variabila %s este utilizata fara sa fi fost declarata!\n", @1.first_line, @1.first_column, $2);
				yyerror(msg);
				YYERROR;
	  		}
		}
		else
		{
			sprintf(msg,"%d:%d Eroare semantica: Variabila %s este utilizata fara sa fi fost declarata!\n", @1.first_line, @1.first_column, $2);
			yyerror(msg);
			YYERROR;
		}
    }
	| TOK_PRINT TOK_LEFTP TOK_STRING TOK_RIGHTP
	{
		$3=$3+1;
		$3[strlen($3)-1]='\0';
		cout<<$3<<"\n";
	}
	| TOK_SCAN TOK_IDENTIFIER
	{
		 if (ts != NULL) {
            char input[256];
            printf("Introduceti valoarea pentru %s: ", $2);
            if (fgets(input, sizeof(input), stdin) != nullptr) {
                double value;
                if (sscanf(input, "%lf", &value) == 1) {
					if(ts->getTipVar($2)==1)
					{
						value=(int)value;
						ts->setValue($2, value);
					}
					if(ts->getTipVar($2)==2)
					{
						value=(float)value;
						ts->setValue($2, value);
					}
					if(ts->getTipVar($2)==3)
					{
						ts->setValue($2, value);
					}
                   
                } else {
                    printf("Eroare: Valoarea invalida: %s!\n", $2);
                    YYERROR;
                }
            }
        } else {
            printf("Eroare: Variabila %s nu a fost declarată!\n", $2);
            YYERROR;
        }
	}
	;
CONDITION : E TOK_EQ E      {$$ = $1 == $3;}
        |   E TOK_NEQ E     {$$ = $1 != $3;}
        |   E TOK_LT E      {$$ = $1 < $3;}
        |   E TOK_LTE E     {$$ = $1 <= $3;}
        |   E TOK_GT E      {$$ = $1 > $3;}
        |   E TOK_GTE E     {$$ = $1 >= $3;}
        ;
BLOCK : TOK_LEFTBP S TOK_RIGHTBP
	    ;
IF_ELSE : TOK_IF TOK_LEFTP CONDITION TOK_RIGHTP BLOCK
/*{
	if($3)
	{
		executeStatements($5);
	}
}*/
        | TOK_IF TOK_LEFTP CONDITION TOK_RIGHTP TOK_ELSE BLOCK
		/*{
			if($3==0)
			{
				executeStatements($6);
			}
		}*/
        ;
/*STATEMENT : TOK_IF '(' CONDITION ')' '{' STATEMENTS '}' {
    if ($3) {  // Verifică condiția
        executeStatements($5);  // Apelează funcția care execută STATEMENTS
    }
}
;
STATEMENTS : STATEMENT { $$ = $1; }
           | STATEMENTS STATEMENT { $$ = $1; $$->next = $2; }
           ;*/

E : E TOK_PLUS E
  { 
    $$ = $1 + $3; 
    if (ts->inInterval($$) == false)
        {
            sprintf(msg,"%d:%d Eroare semantica: Overflow!\n", @1.first_line, @1.first_column);
            yyerror(msg);
            YYERROR;
        }
  }
    | E TOK_MINUS E
  { 
    $$ = $1 - $3; 
    if (ts->inInterval($$) == false)
        {
            sprintf(msg,"%d:%d Eroare semantica: Overflow!\n", @1.first_line, @1.first_column);
            yyerror(msg);
            YYERROR;
        }
  }
    | E TOK_MULT E 
  { 
    $$ = $1 * $3; 
    if (ts->inInterval($$) == false)
        {
            sprintf(msg,"%d:%d Eroare semantica: Overflow!\n", @1.first_line, @1.first_column);
            yyerror(msg);
            YYERROR;
        }
  }
    | E TOK_DIV E 
	{
		if($3 == 0)
		{
			sprintf(msg,"%d:%d Eroare semantica: Impartire la zero!\n", @1.first_line, @1.first_column);
	      	yyerror(msg);
	      	YYERROR;
	    } 
	  	else 
		{ 
			$$ = $1 / $3;
            if (ts->inInterval($$) == false)
            {
                sprintf(msg,"%d:%d Eroare semantica: Overflow!\n", @1.first_line, @1.first_column);
                yyerror(msg);
                YYERROR;
            } 
		} 
	}
    | TOK_LEFTP E TOK_RIGHTP { $$ = $2; }
    | VAR_INT { $$ = $1; }
	| VAR_FLOAT { $$ = $1; }
	| VAR_DOUBLE { $$ = $1; }
	| TOK_IDENTIFIER{
		$$=ts->getValue($1);
	}
	|CAST_INT {
		$$ =(double) $1;
	}
	|CAST_FLOAT {
		$$ =(double) $1;
	}
	|CAST_DOUBLE {
		$$ =(double) $1;
	}
    ;
CAST_INT: TOK_LEFTP TOK_INT TOK_RIGHTP TOK_IDENTIFIER
	{
		$$=static_cast<int> (ts->getValue($4));
		ts->setTipVar($4,1);
	}
	;
CAST_FLOAT: TOK_LEFTP TOK_FLOAT TOK_RIGHTP TOK_IDENTIFIER
	{
		$$=static_cast<float> (ts->getValue($4));
		ts->setTipVar($4,2);
	}
	;
CAST_DOUBLE: TOK_LEFTP TOK_DOUBLE TOK_RIGHTP TOK_IDENTIFIER
	{
		$$=static_cast<double> (ts->getValue($4));
		ts->setTipVar($4,3);
	}
	;
%%

void executeScriptFile(const char* filename)
{
    if(isCorected==1)
    {
        printf("Se deschide fisierul: %s\n", filename);
        yyin = fopen(filename, "r");
        if (!yyin) {
            perror("Eroare la deschiderea fisierului\n");
            return;
        }
    }
 
    yyparse();
    fclose(yyin);
}

void executeCommand(char* command)
{
    if(isCorected==1)
    {   
        yyin = fmemopen(command, strlen(command), "r");
        if (!yyin) {
            perror("Eroare la deschiderea fisierului");
            return;
        }
    }

    yyparse();
    fclose(yyin);
}

int main(int argc, char *argv[])
{
    char command[200];
    printf("Introdu o comanda sau ruleaza scriptul din fisier 'run <filename>'");
    while(1)
    {
        printf("> ");
        if(fgets(command, sizeof(command), stdin)==NULL)
        {
            break;
        }
        command[strcspn(command,"\n")]=0;

        if(strncmp(command, "run",3)==0)
        {
            executeScriptFile(command+4);
            ts->printVars();
        }
        else{
            executeCommand(command);
            ts->printVars();
        }
    }

    return 0;
}


int yyerror(const char* msg)
{
    printf("Error: %s\n", msg);
    return 1;
}