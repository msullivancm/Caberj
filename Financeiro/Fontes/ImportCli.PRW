#include "rwmake.ch"
#include "tbicode.ch"
#include "tbiconn.ch"
#include "ap5mail.ch"


***********************
User Function ImportCli
***********************

Private oLeTxt
Private cString := "SA1"    
Private diretM:="\\srvap02\Protheus8\Protheus_Data\system\ARQIMP\" 
//Private diretM:="M:\Protheus_Data\System\ARQIMP\" 

//PREPARE ENVIRONMENT EMPRESA '01' FILIAL '01' MODULO "SIGAFIN"

dbSelectArea(cString)
dbSetOrder(1)

/*@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Leitura de Arquivo Texto")
@ 02,10 TO 080,190
@ 10,018 Say " Este programa ira importar os dados para a tabela de Clientes, "
@ 18,018 Say " conforme os parametros definidos pelo usuario, com os registros "
@ 26,018 Say " do arquivo                                                      "

@ 70,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered*/

OkLeTxt()

Return

***********************
Static Function OkLeTxt
***********************

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private cEOL    := "CHR(13)+CHR(10)"
Private cArqTxt 
Private nHdl    

CopiaUtl()

If Empty(cEOL)
    cEOL := CHR(13)+CHR(10)
Else
    cEOL := Trim(cEOL)
    cEOL := &cEOL
Endif       

aArqs := Directory(diretM+"PEND\MOVSA1*.TXT")  

for x:=1 to len(aArqs)  

	cArqTxt := diretM+"PEND\"+aArqs[x,1]
	nHdl    := fOpen(cArqTxt,68)
	
	If nHdl == -1
	    MsgAlert("O arquivo de nome "+cArqTxt+" nao pode ser aberto! Verifique os parametros.","Atencao!")
	    Return
	Endif
	
	//Processa({|| RunCont() },"Processando...")     
	RunCont()
	
next

Return 

***********************
Static Function RunCont
***********************

Local nTamFile, nTamLin, cBuffer, nBtLidos, inserir  
Private aLista := {}

QOut("runcont")

nTamFile := fSeek(nHdl,0,2)
fSeek(nHdl,0,0)
nTamLin  :=461+Len(cEOL)
cBuffer  := Space(nTamLin) // Variavel para criacao da linha do registro para leitura

nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da primeira linha do arquivo texto

//ProcRegua(nTamFile) // Numero de registros a processar

While nBtLidos >= nTamLin

//    IncProc()

dbSelectArea(cString) // TABELA 

if (Substr(cBuffer,01,01)=="U") .And. (dbSeek( XFILIAL(cString)+Substr(cBuffer,02,06),.F.) )     
 RecLock(cString,.F.)      
 inserir:=.F.
ELSE
 RecLock(cString,.t.) 
 inserir:=.T.
ENDIF

if (inserir==.T.) .Or. ((Substr(cBuffer,01,01)=="U") .And. ((A1_COD == Substr(cBuffer,02,06)) .and. !Eof()))

    SA1->A1_FILIAL := XFILIAL(cString)      
    SA1->A1_COD  := Substr(cBuffer,02,06) 
    SA1->A1_LOJA := "01"  
    SA1->A1_NOME := AllTrim(Substr(cBuffer,8,50))   
    SA1->A1_PESSOA := "F"  
    SA1->A1_NREDUZ := AllTrim(Substr(cBuffer,58,20))  
    SA1->A1_TIPO := "F"  
    IF Substr(cBuffer,106,1) == "1"
      SA1->A1_END := Substr(cBuffer,107,40)  
      SA1->A1_MUN := Substr(cBuffer,149,50)     
      SA1->A1_EST := Substr(cBuffer,147,2) 
      SA1->A1_BAIRRO := Substr(cBuffer,179,50) 
      SA1->A1_CEP := Substr(cBuffer,209,8)
      SA1->A1_DDD := Substr(cBuffer,217,2) 
      SA1->A1_TEL := Substr(cBuffer,219,20)
      //
      SA1->A1_ENDCOB := Substr(cBuffer,107,40)
      SA1->A1_BAIRROC := Substr(cBuffer,179,50)
      SA1->A1_MUNC := Substr(cBuffer,149,50)   
      SA1->A1_ESTC := Substr(cBuffer,147,2) 
      SA1->A1_CEPC := Substr(cBuffer,209,8)   
    ELSE     
      SA1->A1_END := Substr(cBuffer,239,40)
      SA1->A1_MUN := Substr(cBuffer,281,50)     
      SA1->A1_EST := Substr(cBuffer,279,2) 
      SA1->A1_BAIRRO := Substr(cBuffer,311,50)
      SA1->A1_CEP := Substr(cBuffer,341,8)   
      SA1->A1_DDD := Substr(cBuffer,349,2) 
      SA1->A1_TEL := Substr(cBuffer,351,20)
      //
      SA1->A1_ENDCOB := Substr(cBuffer,239,40)
      SA1->A1_BAIRROC := Substr(cBuffer,311,50)
      SA1->A1_MUNC := Substr(cBuffer,281,50)   
      SA1->A1_ESTC := Substr(cBuffer,279,2) 
      SA1->A1_CEPC := Substr(cBuffer,341,8)   
    ENDIF 
    SA1->A1_DTNASC := STOD(SUBSTR(cBuffer,078,8))   
    SA1->A1_Cgc := Substr(cBuffer,95,11)
    SA1->A1_EMAIL := Substr(cBuffer,382,40)   
    SA1->A1_XBANCO := VAL(Substr(cBuffer,443,3)) 
    SA1->A1_XAGENC := VAL(Substr(cBuffer,446,4))
    SA1->A1_XCONTA := Substr(cBuffer,450,11)

DbSelectArea(cString)
MSUnLock()
lRet := IIf(Empty(Posicione("SA1",1,xFilial("SA1")+Substr(cBuffer,02,06),"A1_NOME")),.T.,.F.)
If lRet
	Aadd(aLista,{"Cliente nº " + Substr(cBuffer,02,06) + " não foi incluído"})
EndIf
endif

    nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da proxima linha do arquivo texto

    dbSkip()
EndDo

fClose(nHdl)           
fEnvMail()

_copyfile(diretM+"PEND\"+aArqs[x,1],diretM+"LIDO\"+aArqs[x,1])  
Erase(diretM+"PEND\"+aArqs[x,1])   

//Close(oLeTxt)

Return       

************************
Static Function CopiaUtl
************************
Local aArqs2 := {}

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

diret := "\\srvbd\utl\"
aArqs2 := Directory(diret+"MOVSA*.TXT")               

For x:= 1 to len(aArqs2)   
_copyfile(diret+aArqs2[x,1],diretM+"PEND\"+aArqs2[x,1])
Erase(diret+aArqs2[x,1])
Next

Return

***********************
Static Function fEnvMail
***********************

   Local I


   cSubject := "Aviso de Importação de Clientes"
   cBody := '<html>' + Chr(10)+chr(13)
   cBody += '<head>' + Chr(10)+chr(13) + '</head> <body>'
   cBody += '<p align="center"><b>Relatório de Importação de Clientes</b></p>' 	  
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
