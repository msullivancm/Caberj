#include "rwmake.ch"
#include "tbicode.ch"
#include "tbiconn.ch"
#include "ap5mail.ch"

User Function ImportDep

//PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01" MODULO "SIGAFIN"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private oLeTxt

Private cString := "SZ2"
Private diretM:="\\srvap02\Protheus8\Protheus_Data\system\ARQIMP\" 

QOut("ImportDep")
QOut(cFilAnt)
QOut(cEmpAnt)

dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Leitura de Arquivo Texto")
@ 02,10 TO 080,190
@ 10,018 Say " Este programa ira importar os dados para a tabela de Dependentes, "
@ 18,018 Say " conforme os parametros definidos pelo usuario, com os registros "
@ 26,018 Say " do arquivo                                                       "

@ 70,128 BMPBUTTON TYPE 01 ACTION 
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)*/

OkLeTxt()
//Close(oLeTxt)

//Activate Dialog oLeTxt Centered

Return


Static Function OkLeTxt

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abertura do arquivo texto                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

CopiaUtl()

Private cEOL    := "CHR(13)+CHR(10)"
If Empty(cEOL)
    cEOL := CHR(13)+CHR(10)
Else
    cEOL := Trim(cEOL)
    cEOL := &cEOL
Endif       

aArqs := Directory(diretM+"PEND\MOVSZ2*.TXT")  

for x:=1 to len (aArqs)  

Private cArqTxt := diretM+"PEND\"+aArqs[x,1]
Private nHdl    := fOpen(cArqTxt,68)

If nHdl == -1
    MsgAlert("O arquivo de nome "+aArqs[x,1]+" nao pode ser aberto! Verifique os parametros.","Atencao!")
    Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a regua de processamento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//Processa({|| RunCont() },"Processando...")     

RunCont()

next
Return 

Static Function RunCont

Local nTamFile, nTamLin, cBuffer, nBtLidos, inserir 
Private aLista := {}

//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º Lay-Out do arquivo Texto gerado:                                º
//ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
//ºCampo           ³ Inicio ³ Tamanho                               º
//ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
//º ??_FILIAL     ³ 01     ³ 02                                    º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

nTamFile := fSeek(nHdl,0,2)
fSeek(nHdl,0,0)
nTamLin  :=223+Len(cEOL)
cBuffer  := Space(nTamLin) // Variavel para criacao da linha do registro para leitura

nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da primeira linha do arquivo texto

//ProcRegua(nTamFile) // Numero de registros a processar


While nBtLidos >= nTamLin

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Incrementa a regua                                                  ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

    //IncProc()


    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Grava os campos obtendo os valores da linha lida do arquivo texto.  ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea(cString) // TABELA 


If (Substr(cBuffer,01,01)=="U") .And. (dbSeek( XFILIAL(cString)+Substr(cBuffer,02,06)+Substr(cBuffer,14,11),.F.))   
 RecLock(cString,.F.)      
 inserir:=.F.
ELSE
 RecLock(cString,.t.) 
 inserir:=.T.
ENDIF

if (inserir==.T.) .OR. ((Substr(cBuffer,01,01)=="U") .And. ((Z2_filial ==  XFILIAL(cString)) .AND. (Z2_CODCLI == Substr(cBuffer,02,06)) .AND. (Z2_NUMASS == Substr(cBuffer,14,11)) .and. !Eof()))
    
    SZ2->Z2_FILIAL := XFILIAL(cString)      
    SZ2->Z2_CODCLI  := Substr(cBuffer,02,06)  
    SZ2->Z2_CODDEP  := Substr(cBuffer,08,06)    
    SZ2->Z2_NUMASS  := Substr(cBuffer,14,11)     
    SZ2->Z2_CODPLN  := Substr(cBuffer,25,10)  
    SZ2->Z2_NOME := AllTrim(Substr(cBuffer,35,50))           
    SZ2->Z2_DTNASC :=STOD(SUBSTR(cBuffer,85,8))  
    SZ2->Z2_DATINC :=STOD(SUBSTR(cBuffer,93,8))                        
    SZ2->Z2_DATEXC :=STOD(SUBSTR(cBuffer,101,8)) 
    SZ2->Z2_SALBAS :=val(Substr(cBuffer,109,12))/100
    SZ2->Z2_INDJUD  := Substr(cBuffer,121,01)
    SZ2->Z2_OBSJUD  := Substr(cBuffer,122,100)
    SZ2->Z2_OPTINT  := Substr(cBuffer,222,01)

DbSelectArea(cString)
MSUnLock()    
lRet := IIf(Empty(Posicione("SZ2",1,xFilial("SZ2")+Substr(cBuffer,02,06)+Substr(cBuffer,14,11),"Z2_NOME")),.T.,.F.)
If lRet
	Aadd(aLista,{"Dependente nº " + Substr(cBuffer,14,11) + " não foi incluído"})
EndIf

endif
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Leitura da proxima linha do arquivo texto.                          ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

    nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da proxima linha do arquivo texto

    dbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ O arquivo texto deve ser fechado, bem como o dialogo criado na fun- ³
//³ cao anterior.                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

fClose(nHdl)
fEnvMail()
//Comando utilizado para copiar arquivos da pasta pend para lido
_copyfile(diretM+"PEND\"+aArqs[x,1],diretM+"LIDO\"+aArqs[x,1])  
Erase(diretM+"PEND\"+aArqs[x,1])   

//Close(oLeTxt)  

Return       


Static Function CopiaUtl

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aArqs2 := {}   

diret:="\\srvbd\utl\"
aArqs2 := Directory(diret+"MOVSZ2*.TXT")      

For x:= 1 to len(aArqs2)     
  _copyfile(diret+aArqs2[x,1],diretM+"PEND\"+aArqs2[x,1])     
  Erase(diret+aArqs2[x,1])
Next
Return     

***********************
Static Function fEnvMail
***********************

   Local I


   cSubject := "Aviso de Importação de Dependentes
   cBody := '<html>' + Chr(10)+chr(13)
   cBody += '<head>' + Chr(10)+chr(13) + '</head> <body>'
   cBody += '<p align="center"><b>Relatório de Importação de Dependentes</b></p>' 	  
   For I:= 1 to Len(aLista)
	   cBody += '<ul>'
	   cBody += '<li>' + aLista[I,1] + '</li>' 
	   cBody += '</ul>'
   Next
   cBody += '</body> </html>'
     
   cTo := "desenvolvimento@caberj.com.br"             
   _cMailServer := GetMv("MV_WFSMTP")
   
   cErrorMsg := ""
   connect smtp server _cMailServer account GetMv("MV_WFACC") password GetMv("MV_WFPASSW")
   send mail from GetMv("MV_WFMAIL") to cTo subject cSubject body cbody 
   GET MAIL ERROR cErrorMsg    

   DISCONNECT SMTP SERVER
   
   QOut(cErrorMsg)

Return
