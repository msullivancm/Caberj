#INCLUDE "PROTHEUS.CH"
#INCLUDE "TopConn.Ch"
#INCLUDE "FONT.CH"
#Include "rwmake.ch"
#Include "plsmger.ch"
#Include "plsmlib.ch"
#Include "colors.ch" 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PSCP002  บ Autor ณ Antonio Araujo     บ Data ณ  08/06/2008 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relat๓rio  de Co-Participa็ใo  		                       บฑฑ
ฑฑบ          ณ antonio.pires@totvs.com.br                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User function PSCP002

Private oLeTxt
Private lAbortPrint :=.F.
Private oDlg := NIL
Private cTitulo := "Relat๓rio de Co-Participa็ใo."
Private oPrn    := NIL
Private oFont1  := NIL
Private oFont2  := NIL
Private oFont3  := NIL
Private oFont4  := NIL
Private oFont5  := NIL
Private oFont6  := NIL
Private cPerg   := "CABPEC"
Private nLin    := 0  
Private nLin1    := 0
Private nPagina := 0
Private cMesI
Private cAnoI
Private cMesF
Private cAnoF
Private cPlano
Private cPnome    
Private cNumse  
Private cCodAss
Private cNomAss
Private nCont := 0
Private lAnalit := .F.

DEFINE FONT oFont1 NAME "System" SIZE 0,12 OF oPrn BOLD
DEFINE FONT oFont2 NAME "Arial" SIZE 0,12 OF oPrn BOLD
DEFINE FONT oFont3 NAME "Arial" SIZE 0,12 OF oPrn
DEFINE FONT oFont4 NAME "Courier New" SIZE 0,08 OF oPrn BOLD
DEFINE FONT oFont5 NAME "Arial" SIZE 0,18 OF oPrn BOLD
DEFINE FONT oFont6 NAME "Courier New" BOLD  
DEFINE FONT oFont7 NAME "Arial" SIZE 0,10 OF oPrn 
DEFINE FONT oFont8 NAME "Arial" SIZE 0,16 OF oPrn BOLD

@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Relat๓rio Co-participa็ใo")
@ 02,10 TO 65,180
@ 10,018 Say " Este relat๓rio ้ destinado a exibir as informa็๕es sobre a     "
@ 18,018 Say " coparticipa็ใo, conforme parโmetros repassados ao relat๓rio.   "
@ 70,098 BMPBUTTON TYPE 05 ACTION AjustaSX1(cPerg)
@ 70,128 BMPBUTTON TYPE 01 ACTION OkRelat()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

Return
      


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPSCP002   บAutor  ณMicrosiga           บ Data ณ  08/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function OkRelat() 

Pergunte(cPerg,.F.)

cMesI :=Substr(mv_par03,1,2)
cAnoI :=Substr(mv_par03,3,6)

mv_par03 := cAnoI + cMesI

oPrn := TMSPrinter():New(cTitulo)  	
//oPrn :SetPortrait() 
oPrn:SetLandsCape()

oPrn:Setup()

MsAguarde({||BuscaDados()},"Aguarde","Buscando dados no servidor...",.T.)


Processa({||Mont_impr(),"Ordenando registros... Aguarde..."})

*-------------------------------------------------------------------------------------*
* Cria interface com o usuario
*-------------------------------------------------------------------------------------*
DEFINE MSDIALOG oDlg FROM 264,182 TO 441,613 TITLE cTitulo OF oDlg PIXEL
@ 004,010 TO 082,157 LABEL "" OF oDlg PIXEL

@ 015,017 SAY "Esta rotina tem por objetivo imprimir  " OF oDlg PIXEL Size 150,010 FONT oFont6 COLOR CLR_HBLUE
@ 030,017 SAY "o Relat๓rio de Co-Participa็ใo conforme" OF oDlg PIXEL Size 150,010 FONT oFont6 COLOR CLR_HBLUE
@ 045,017 SAY "parametrizado (analitico ou sintetico)." OF oDlg PIXEL Size 150,010 FONT oFont6 COLOR CLR_HBLUE

@  6,167 BUTTON "&Imprime" SIZE 036,012 ACTION oPrn:Print()   OF oDlg PIXEL
@ 28,167 BUTTON "&Configura"   SIZE 036,012 ACTION oPrn:Setup()   OF oDlg PIXEL
@ 49,167 BUTTON "&Visualiza" SIZE 036,012 ACTION oPrn:Preview() OF oDlg PIXEL
@ 70,167 BUTTON "Sai&r"    SIZE 036,012 ACTION oDlg:End()     OF oDlg PIXEL

ACTIVATE MSDIALOG oDlg CENTERED

oPrn:End()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMont_impr บAutor  ณMicrosiga           บ Data ณ  08/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta o objeto com os detalhes                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Mont_impr()
Local nCont1		:= 0
Private nTotPar	:= 0  // Total de Co-Participa็ใo do Associdado
Private nTotCob	:= 0  // Total de Cobrados do Associado
Private nTotNco	:= 0  // Total de Nใo Cobrados do Associado    
Private nTPaPla	:= 0  // Total de Co-Participa็ใo do Plano
Private nTCobPla	:= 0  // Total de Cobrados do Plano
Private nTNcoPla	:= 0  // Total de Nใo Cobrados do Plano    
Private nTPaGer	:= 0  // Total de Co-Participa็ใo do Geral
Private nTCobGer	:= 0  // Total de Cobrados do Geral
Private nTNcGer	:= 0  // Total de Nใo Cobrados do Geral  
Private nValIni	:=0
Private nValFim	:=0

Cabec(1)          

ProcRegua(nCont)
lAnalit := mv_par07<>1 //se <> 1, analitico

Do While TRB->(!EOF())  
	
	If nLin > 2300
			Cabec(2)        
	EndIf          
	
	cPlano:=TRB->BD6_CODPLA
	cPnome:=TRB->BI3_NREDUZ   
	
	nTPaPla:=0                             
	nTCobPla:=0  
	nTNcoPla:=0
  
   nLin:=nLin + 40                       	   
    
	oPrn:Say (nLin,0050,cPlano,oFont2)
	oPrn:Say (nLin,0200,cPnome,oFont2)
	nLin:=nLin + 20 

	Do	While TRB->(!EOF())  .and. cPlano = TRB->BD6_CODPLA  
	
		If nLin > 2300
			cabec(2)
		EndIf		      
	  
		cCodAss:=TRB->BD6_OPEUSR + TRB->BD6_CODEMP + TRB->BD6_MATRIC + TRB->BD6_TIPREG + TRB->BD6_DIGITO
		cNomAss:=TRB->BA1_NOMUSR
		
		nTotPar  := 0
		nTotCob := 0
		nTotNco := 0
	                                                                         
		Do	While TRB->(!EOF())  .and. cCodAss = TRB->BD6_OPEUSR + TRB->BD6_CODEMP + TRB->BD6_MATRIC + TRB->BD6_TIPREG + TRB->BD6_DIGITO .and. cPlano = TRB->BD6_CODPLA  
	
			// Rotina que calcula o Co-Particiapa็ใo / Cobrado / Nใo Cobrado
			nTotPar := nTotPar + TRB->VALOR                 // Total da Co-Participa็ใo por Associado
			cNumse := Alltrim(TRB->BD6_NUMSE1)
			
			IF cNumse <> ''
					nTotCob := nTotCob + TRB->VALOR           // Total da Cobrado por Associado
			ELSEIF cNumse = ''
					nTotNco := nTotNco + TRB->VALOR           // Total de Nใo Cobrado Por Associado
			ENDIF   
			
			nCont1++
			IncProc("Processando: "+StrZero(nCont1,7))
			
			TRB->(DbSkip())
			
		EndDo
						
		nValIni := mv_par05
		nValFim := mv_par06
		
		If (mv_par04==1) .Or. (mv_par04==2 .And. ((nTotCob >= nValIni) .and. (nTotCob <= nValFim))) .Or. ;
		   (mv_par04==3 .And. ((nTotNco >= nValIni) .and. (nTotNco <= nValFim)))
		   
			If lAnalit
			
				nLin:=nLin + 60
			
				oPrn:Say (nLin,0100,cCodAss														,oFont7)
				oPrn:Say (nLin,0800,cNomAss			 							 				,oFont7)
				oPrn:Say (nLin,1870,Transform(nTotPar,"@E 999,999.99")					,oFont7)
				oPrn:Say (nLin,2295,Transform(nTotCob,"@E 999,999.99")					,oFont7)
				oPrn:Say (nLin,2755,Transform(nTotNco,"@E 999,999.99")					,oFont7)
			Endif
			
			// Totais Gerais por Associado			
			nTPaPla:=nTPaPla + nTotPar
			nTCobPla:=nTCobPla + nTotCob
			nTNcoPla:=nTNcoPla + nTotNco		   
		   
		Endif		
	
	EndDo	   
           
  	nLin:=nLin + 60

	// Totais Gerais do Associado por Plano
	oPrn:Say (nLin,30,"-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"					,oFont2)  
	nLin:=nLin + 30
	oPrn:Say (nLin,0700,"TOTAL POR PLANO : "		 													,oFont2)
	oPrn:Say (nLin,1780,Transform(nTPaPla,"@E 999,999,999,999.99")						,oFont2)
	oPrn:Say (nLin,2200,Transform(nTCobPla,"@E 999,999,999,999.99")					,oFont2)   
	oPrn:Say (nLin,2600,Transform(nTNcoPla,"@E 999,999,999,999.99")					,oFont2)
  	nLin:=nLin + 80
	
	nTPaGer:=nTPaGer + nTPaPla
	nTCobGer:=nTCobGer + nTCobPla
	nTNcGer:=nTNcGer + nTNcoPla
	
EndDo 

// Totais Gerais dos Associados de Todos os Planos   
oPrn:Say (nLin,30,"---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"					,oFont2)  
nLin:=nLin + 30
oPrn:Say (nLin,0700,"TOTAL GERAL : "		 											,oFont2)
oPrn:Say (nLin,1780,Transform(nTPaGer,"@E 999,999,999,999.99")					,oFont2)
oPrn:Say (nLin,2200,Transform(nTCobGer,"@E 999,999,999,999.99")				,oFont2)
oPrn:Say (nLin,2600,Transform(nTNcGer,"@E 999,999,999,999.99")					,oFont2)

nLin:=nLin + 80

TRB->(DbCLoseArea())

oPrn:EndPage()

nPagina++

Return   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCabec     บAutor  ณMicrosiga           บ Data ณ  08/13/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Cabec(ntipo)                                             

If ntipo = 1
	oPrn:StartPage()
Else
	oPrn:EndPage()         
EndIf	

nPagina++
 
oPrn:box (0035,0030,190,3380)
oPrn:Say (0040,1200,"Relat๓rio de Co-Participa็๕es ",oFont5)   
oPrn:Say (0080,0050,"PLA/PSCP002.PRW",oFont2)
oPrn:Say (0130,1550,"M๊s/Ano: "+cMesI+"/"+cAnoI,oFont2)
oPrn:Say (0080,3000,"Pagina:"+Str(nPagina),oFont2)  
    

nLin:=0190
oPrn:box (nLin,0030,250,3380)    
oPrn:Say (nLin,0050,"Cod. do Associado",oFont2)
oPrn:Say (nLin,0800,"Nome do Associado",oFont2)
oPrn:Say (nLin,1800,"Co-Participa็ใo",oFont2)
oPrn:Say (nLin,2300,"Cobrado",oFont2)
oPrn:Say (nLin,2700,"Nใo Cobrado",oFont2)

nLin:=nLin + 50

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPSCP002   บAutor  ณMicrosiga           บ Data ณ  08/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSX1(cPerg)
       
PutSx1(cPerg,"01","Codigo do Plano Inicial ?"		,"","","mv_ch01","C",04,0,0,"G","","YBI3","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"02","Codigo do Plano Final ?"			,"","","mv_ch02","C",04,0,0,"G","","YBI3","","","mv_par02","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"03","Mes e Ano Refer๊ncia ?"			,"","","mv_ch03","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"04","Tipo de Pesquisa de Valor "		,"","","mv_ch04","N",01,0,0,"C","","","","","mv_par04" ,"NORMAL"   ,"NORMAL"   ,"NORMAL"   ,"","COBRADO"   ,"COBRADO",   "COBRADO" ,"NรO COBRADO"   ,"NรO COBRADO",    "NรO COBRADO", "", "" )
PutSx1(cPerg,"05","Valor de ?"							,"","","mv_ch05","N",20,2,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"06","Valor At้ ?"							,"","","mv_ch06","N",20,2,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"07","Tipo de relat๓rio "					,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par07" ,"Sint้tico","Sint้tico","Sint้tico","","Analํtico","Analํtico","Analํtico","","","","","")
PutSx1(cPerg,"08","Empresa De"							,"","","mv_ch08","C",04,0,0,"G","","YBG9","","","mv_par08","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"09","Empresa Ate"							,"","","mv_ch09","C",04,0,0,"G","","YBG9","","","mv_par09","","","","","","","","","","","","","","","","")
      
Pergunte(cPerg,.T.)

Return 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPSCP002   บAutor  ณMicrosiga           บ Data ณ  08/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BuscaDados()
Local cQuery := ""
Local cEnt  := CHR(13)+CHR(10)

cQuery :=" SELECT BD6_CODPLA, BI3_NREDUZ , BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BA1_NOMUSR, BD6_NUMSE1, SUM(BD6_VLRTPF)AS VALOR"+cEnt
cQuery +=" FROM "+RetSqlname("BD6") + " BD6, "+cEnt
cQuery +=         RetSqlName("BI3") + " BI3, "+cEnt
cQuery +=         RetSqlName("BA1")+" BA1 "+cEnt
cQuery +=" WHERE BD6_NUMLOT LIKE '" + AllTrim(mv_par03) + "%' "+cEnt
cQuery +=" AND BD6_NUMLOT <> ' ' "
cQuery +=" AND BD6_BLOCPA <> '1' "+cEnt
cQuery +=" AND BD6_CODPLA BETWEEN '" + AllTrim(mv_par01) + "' AND '" + AllTrim(mv_par02) + "' "+cEnt
cQuery +=" AND BD6_CODEMP BETWEEN '"+mv_par08+"' AND '"+mv_par09+"' "+cEnt
cQuery +=" AND BD6_OPEUSR = '"+PLSINTPAD()+"' "+cEnt
cQuery +=" AND BD6.D_E_L_E_T_ <> '*' "+cEnt   

cQuery +=" AND BI3_FILIAL = '"+xFilial("BI3")+"' "
cQuery +=" AND BD6_CODPLA = BI3_CODIGO "+cEnt
cQuery +=" AND BI3.D_E_L_E_T_ <> '*' "+cEnt   

cQuery +=" AND BA1_FILIAL = '"+xFilial("BA1")+"' "
cQuery +=" AND BD6_OPEUSR = BA1_CODINT "+cEnt
cQuery +=" AND BD6_CODEMP = BA1_CODEMP "+cEnt
cQuery +=" AND BD6_MATRIC =  BA1_MATRIC "+cEnt
cQuery +=" AND BD6_TIPREG = BA1_TIPREG "+cEnt
cQuery +=" AND BD6_DIGITO =  BA1_DIGITO "+cEnt

cQuery +=" AND BA1.D_E_L_E_T_ <> '*' "+cEnt   
cQuery +=" GROUP BY  BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,BA1_NOMUSR,BD6_BLOCPA,BD6_NUMSE1,BD6_CODPLA,BI3_NREDUZ,BD6_NUMLOT "+cEnt
cQuery +=" ORDER BY BD6_CODPLA "+cEnt

cQuery := ChangeQuery(cQuery)

MemoWrite("C:\PSCP002.SQL",cQuery)

PlsQuery(cQuery,"TRB")

Return 