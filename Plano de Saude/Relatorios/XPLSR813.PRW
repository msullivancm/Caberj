
#INCLUDE "PROTHEUS.CH"
#include "PLSR813.CH"
#IFDEF TOP
	#INCLUDE "TOPCONN.CH"
#ENDIF

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � PLSR813 � Autor � Natie Sugahara         � Data � 11/07/03 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Tempo de Espera para consulta                              ����
���          � Gera listagem  de todos as esperas das consultas de todas  ����
���          � as Unidade de Atend.                                       ����
���          � Relaciona Beneficiarios com  mais de 60 minutos de espera  ����
�������������������������������������������������������������������������Ĵ���
���Sintaxe   � PLSR813()                                                  ����
�������������������������������������������������������������������������Ĵ���
��� Uso      � Advanced Protheus                                          ����
�������������������������������������������������������������������������Ĵ���
��� Alteracoes desde sua construcao inicial                               ����
�������������������������������������������������������������������������Ĵ���
��� Data     � BOPS � Programador � Breve Descricao                       ����
�������������������������������������������������������������������������Ĵ���
���          |      |             |                                       ����
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/                                
User Function XPLSR813()
/*��������������������������������������������������������������������������Ŀ
  � Define variaveis padroes para todos os relatorios...                     �
  ����������������������������������������������������������������������������*/
PRIVATE wnRel         
PRIVATE cNomeProg   := "XPLSR813"
PRIVATE nLimite     := 132
PRIVATE nTamanho    := "M"
PRIVATE Titulo		:= oEmToAnsi(STR0001)				//-- Primeiras Consultas Por Unidade
PRIVATE cDesc1      := oEmToAnsi(STR0001)
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BBD"
PRIVATE cPerg       := "PLR813"
PRIVATE Li         	:= 0
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aReturn     := { oEmToAnsi(STR0002), 1,oEmToAnsi(STR0003) , 1, 1, 1, "",1 }
PRIVATE aOrd		:= { STR0004}														//--Unidade de Atendimento
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := ""
PRIVATE cCabec2     := ""

//��������������������������������������������������������������Ŀ
//� Variaveis Utilizadas na funcao IMPR                          �
//����������������������������������������������������������������
PRIVATE cCabec
PRIVATE Colunas		:= 80
PRIVATE AT_PRG  	:= "XPLSR813"
PRIVATE wCabec0 	:= 0
PRIVATE wCabec1		:= ""
PRIVATE wCabec2		:=""
PRIVATE wCabec3		:=""
PRIVATE wCabec4		:=""
PRIVATE wCabec5		:=""
PRIVATE wCabec6		:=""
PRIVATE wCabec7		:=""
PRIVATE wCabec8		:=""
PRIVATE wCabec9		:=""
PRIVATE CONTFL		:=1
PRIVATE cPathPict	:= ""


Pergunte(cPerg,.F.)

/*��������������������������������������������������������������Ŀ
  � Envia controle para a funcao SETPRINT                        �
  ����������������������������������������������������������������*/
wnrel:="XPlsr813"					           //Nome Default do relatorio em Disco
wnrel:=SetPrint(cAlias,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

/*��������������������������������������������������������������������������Ŀ
  | Verifica se foi cancelada a operacao                                     �
  ����������������������������������������������������������������������������*/
If nLastKey  == 27
	Return
Endif
/*��������������������������������������������������������������������������Ŀ
  � Configura impressora                                                     �
  ����������������������������������������������������������������������������*/
SetDefault(aReturn,cAlias)
If nLastKey = 27
	Return
Endif 

MsAguarde({|lEnd| XR813Imp(@lEnd,wnRel,cAlias)},Titulo)

Return


/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � XR813Imp  � Autor � Natie Sugahara        � Data � 11/07/03 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Emite relatorio                                            ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Static Function XR813Imp()
Local   cSQL			:= ""
//Local   cPict			:= "@E    999"
Local   cOperadora		:= ""
Local   cUnidade		:= ""  
//Local   cMedico			:= ""
//Local   cDet     		:= ""
//Local   nPos			:= 0
//Local   nMinAtraso		:= 0
//Local   nOrdem  		:= aReturn[8]

Private  aAtraso			:= {}

PRIVATE aDados 			:= {}
PRIVATE aTotDiaAllUni	:= {}					//-- Total por Dia de Todas as Unidades
PRIVATE aTotLinha		:= {} 					//-- Total Por dia de Cada Unidade
PRIVATE aTotUnidade 	:= {} 					//-- Total p/ Unidade
PRIVATE aTotGeral		:= {}					//-- Total de Todas as Unidades / Dia

/*��������������������������������������������������������������������������Ŀ
  � Acessa parametros do relatorio...                                        �
  � Variaveis utilizadas para parametros                                     �
  ����������������������������������������������������������������������������*/
cOpeDe   	:= mv_par01					//-- Codigo da Operadora de
cOpeAte  	:= mv_par02					//-- Codigo da Operadora Ate
cUnidaDe	:= mv_par03					//-- Codigo da Unidade de Atendimento De
cUnidaAte	:= mv_par04					//-- Codigo da Unidade de Atendimento Ate
dDataDe		:= mv_par05  				//-- Periodo De
dDataAte	:= mv_Par06					//-- Periodo Ate
nSinAnal  	:= mv_par07					//-- Impressao 1-Sintetico( Mensal ) 2 - Analitico (Diario )
nMaior60	:= mv_par08					//-- Relaciona Beneficiarios com  mais de 60 minutos de espera 1-sim 2- nao
nSomAAG	    := mv_par09					//-- Relaciona Beneficiarios somente AAG // Motta
/*��������������������������������������������������������������������������Ŀ
  � Faz filtro no arquivo...                                                 �
  ����������������������������������������������������������������������������*/
#IFDEF TOP        
	// function de aag do oracle-Motta
	//cSQL := "SELECT * FROM "+BBD->(RetSQLName("BBD"))+" WHERE "
	cSQL := "SELECT TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA)) AAG " 
	cSQL += "," + BBD->(RetSQLName("BBD"))+ ".* FROM "+BBD->(RetSQLName("BBD"))+" WHERE "
	//
    cSQL += "BBD_FILIAL = '"+xFilial("BBD")+"' "
	cSQL += "AND D_E_L_E_T_ = ' '  AND "
	cSQL += "BBD_CODINT >= '" + cOpeDe          +"' AND BBD_CODINT <= '"+ cOpeAte   +"' AND "
	cSQL += "BBD_CODLOC >= '" + cUnidaDe        +"' AND BBD_CODLOC <= '"+ cUnidaAte +"' AND "
	cSQL += "BBD_DATA   >= '" + DTOS(dDataDe)   +"' AND BBD_DATA   <= '"+ DTOS(dDataAte)+"' "

	/*��������������������������������������������������������������������������Ŀ
	  � Se houver filtro executa parse para converter expressoes adv para SQL    �
	  ����������������������������������������������������������������������������*/
	If ! Empty(aReturn[7])
		cSQL += " and " + PLSParSQL(aReturn[7])
	Endif 
    // Motta
    If nSomAAG == 2 
      cSQL += " AND TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA))='S' " 
    Endif
	/*��������������������������������������������������������������������������Ŀ
	  � Define order by de acordo com a ordem...                                 �
      ���������������������������������������������������������������������������� */
	If nSinAnal = 2							//-- Analitico  ( Diario )
		cSQL += " ORDER BY BBD_FILIAL + BBD_CODINT + BBD_DATA   + BBD_CODLOC + BBD_CODESP + BBD_CODIGO"
	Else 									//-- Sintetico  ( Mensal )
		cSQL += " ORDER BY BBD_FILIAL + BBD_CODINT + BBD_CODLOC + BBD_CODESP + BBD_CODIGO"
	Endif		
	cSQL := PLSAvaSQL(cSQL)
	TCQUERY cSQL NEW ALIAS "BBDTrb"
#ENDIF
            

BBDTrb->(dbgoTop())

Li 		:= 0
aTotLinha		:= fMontaArray()			 			//-- Total por Dia
aTotDiaAllUni	:= fMontaTabHora()			 			//-- Total por Dia de Todas as Unidades
aTotGeral		:= fMontaTabHora()			 			//-- Total de Todas as Unidades / Dia
aTotUnidade 	:= fMontaTabHora()						//-- Total p/ Unidade
While  !( BBDTrb->(Eof()) )


	/*��������������������������������������������������������������������Ŀ
	  � Verifica se foi abortada a impressao...                            �
	  ����������������������������������������������������������������������*/
	If Interrupcao(lAbortPrint)
		Exit
	Endif

	Impr("","C",,,00,.T.,.T.)
	Impr( oEmToAnsi(STR0005)+ cOperadora + space(1)+ fDesc("BA0", cOperadora,"BA0_NOMINT" ) ,"C",,,00,.T.,.T.)					//-- Operadora
	Impr( oEmToAnsi(STR0011)+ dToc(dDataDe) + " a " + dToc(dDataAte),"C",,,00,.T.)
	aAtraso	:= {}
	
   	If nSinAnal = 1				//-- Sintetico  ( Mensal ) 
  		fSintetico()
	Else						//-- Analitico	( Diario )
  		fAnalitico() 		
    Endif
EndDo
fImpTotal("2")								//-- Total de Todas as Unidades / Dia
If nMaior60 = 1
	Impr("","P")
	fATraso(aAtraso)
Endif

Impr("","F")

/*��������������������������������������������������������������������Ŀ
  � Fecha arquivo...                                                   �
  ����������������������������������������������������������������������*/
BBDTrb->(DbCloseArea())

/*��������������������������������������������������������������������������Ŀ
  � Libera impressao                                                         �
  ����������������������������������������������������������������������������*/
If  aReturn[5] == 1
	Set Printer To
	Ourspool(wnRel)
EndIf
/*��������������������������������������������������������������������������Ŀ
  � Fim do Relat�rio                                                         �
  ����������������������������������������������������������������������������*/
Return
  

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fVerAtraso�Autor  �Microsiga           � Data �  07/11/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica Atraso  (em Min)                                   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function  fVerAtraso()
LOCAL nMin1 := 0
LOCAL nMin2 := 0
LOCAL nMin  := 0
LOCAL cHor1	:= ""
LOCAL cHor2	:= ""

cHor1 	:= BBDTrb->BBD_HORCHE
cHor2	:= BBDTrb->BBD_HORENT
nMin1	:= (Val(SubStr(cHor1,1,2))*60)+Val(SubStr(cHor1,4,2))
nMin2 	:= (Val(SubStr(cHor2,1,2))*60)+Val(SubStr(cHor2,4,2))
nMin	:= (nMin2 - nMin1)
Return(nMin)



/*
�����������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������ͻ��
���Programa  �fTabUnid     �Autor  �Microsiga           � Data �  07/11/03   ���
����������������������������������������������������������������������������͹��
���Desc.     �Monta Array com os intervalos do dia                           ���
���          �Armazena valores de cada Unidade                               ���
����������������������������������������������������������������������������͹��
���Uso       � AP                                                            ���
����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������
�����������������������������������������������������������������������������

Static Function  fTabUnid()
Local nX	:= 0
Local aArray:= {}

For nX:= 1 to 23
	aadd( aArray,{strZero(nX,2),0,0,0, "" } )
Next nX
aAdd(  aArray ,{"00"    ,0,0,0,""} )
Return(aArray)
*/



/*
�����������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������ͻ��
���Programa  �fMontaTabHora�Autor  �Microsiga           � Data �  07/11/03   ���
����������������������������������������������������������������������������͹��
���Desc.     �Monta Array com os intervalos do dia                           ���
���          �                                                               ���
����������������������������������������������������������������������������͹��
���Uso       � AP                                                            ���
����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function  fMontaTabHora()
Local nX	:= 0
Local aArray:= {}

For nX:= 1 to 23
	aadd( aArray,{strZero(nX,2),0,0,0} )
Next nX
aAdd(  aArray ,{"00"    ,0,0,0} )
Return(aArray)
                                


Static Function fMontaArray()
Local aArray:= {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
Return(aArray)

 /*
�����������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������ͻ��
���Programa  �fImpr        �Autor  �Microsiga           � Data �  07/11/03   ���
����������������������������������������������������������������������������͹��
���Desc.     �Imprime                                                        ���
���          �                                                               ���
����������������������������������������������������������������������������͹��
���Uso       � AP                                                            ���
����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fImpr(cChave)

Local cDet	:= ""
Local lSalta	:= .F.
Local cPict 	:= "@E 9999"
Local cPictPerc	:= "@E 999"
Local nx		:= 0
Local nY		:= 0
Local nCol		:= 00
Local nTotal	:= 0
Local nTotGer	:= 0 

Aeval(aDados ,{|x|nTotGer	+= x[2]+x[3]+x[4] })

For nY := 1 to 4
	For nX := 1 to  Len(aDados)
		If nY = 1 
			nCol:= If(nX =1,02,nCol)
			Impr(aDados[nX,nY]                 	    , "C",,,nCol,.F.)
		Else
			Impr(Transform(aDados[nX,nY], cPict)   , "C",,,nCol,.F.)
			nTotal				+= aDados[nX,nY]
			aTotLinha[nX]		:= aTotLinha[nX]       +aDados[nX,nY] 		//-- Total Por dia de Cada Unidade
			aTotDiaAllUni[nX,nY]:= aTotDiaAllUni[nX,nY]+aDados[nX,nY]		//-- Total por Dia de Todas as Unidades
 			aTotGeral[nX,nY]	:= aTotGeral[nX,nY]    +aDados[nX,nY]		//-- Total de Todas as Unidades / Dia 
		Endif
		nCol += 5
	Next nX
	nCol := 120
	If nY = 1 
		cDet	:= " Tot   %"
	Else
		cDet	:= Transform(nTotal, cPict) + space(1)
		cDet 	+= Transform( (nTotal / nTotGer )* 100,cPictPerc) + space(1)
		cDet	+= If(nY=2,"<30",if(nY=3,">30<=60",">60") )
	Endif
	Impr( cDet, "C",,,nCol,.T.)
	nCol	:= 00
	nTotal 	:= 0
Next nY 

/*��������������������������������������������������������������������������Ŀ
  � Total Por Dia / Unidade                                                  �
  ���������������������������������������������������������������������������� */
fImprTotLinha( nTotGer )

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLSR813   �Autor  �Microsiga           � Data �  07/12/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fImprTotLinha( nTotGer )
Local nx		:= 0 
Local ncol		:= 0
Local cPict 	:= "@E 9999"
//Local cPictPerc := "@E 999"
//Local lSalta 	:= .F.

Impr(__PrtThinLine() ,"C")
For nX:= 1 to Len(aTotLinha)
   	Impr(Transform(aTotLinha[nx], cPict) ,"C",,,nCol,.F.)
	nCol += 05
next nX 
Impr(Transform(nTotGer,cPict) ,"C",,,120,.T.)
Impr(__PrtThinLine() ,"C")  
Impr("","C")
If li + 4 >=58
	li := 0
Endif	
aTotLinha		:= fMontaArray()			 			//-- Total Por dia de Cada Unidade
Return(nil)


Static Function ConvertData(cData )
Return ( substr(cData,7,2) + "/" + substr( cData,5,2) + "/" + substr(cData,1,4) )
                         
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fImpTotal �Autor  �Microsiga           � Data �  07/12/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fImpTotal(cTip, cData )
Local cPict := "@E 9999"
Local cPictPerc	:= "@E 999"
Local nY 	 := 0
Local nX	 := 0
Local nCol	 := 00
Local nTotal := 0
Local ntotGer:= 0
Local aArray:= If(cTip ="1",aTotDiaAllUni,aTotGeral  )

DEFAULT	cData := ""

/*
aTotDiaAllUni	- Total por Dia de Todas as Unidades
aTotGeral		- Total de Todas as Unidades / Dia
*/

Aeval(aArray ,{|x|nTotGer	+= x[2]+x[3]+x[4] })

If cTip = "1"
	Impr("Total Dia " + cData  ,"C",,,00,.T.)
ElseIf cTip = "2"
	Impr("Total Geral ","C",,,00,.T.) 
Endif
For nY := 1 to 4
	For nX := 1 to  Len(aArray)
		If nY = 1
			nCol:= If(nX =1,02,nCol)
			Impr(aArray[nX,nY]                  , "C",,,nCol,.F.)
		Else
			Impr(Transform(aArray[nX,nY], cPict), "C",,,nCol,.F.)
			nTotal 			+= aArray[nX,nY]
			aTotLinha[nX]	:= aTotLinha[nX]  +aArray[nX,nY] 		//-- Total Por dia de Cada Unidade
		Endif 
		nCol += 5
	Next nX
	nCol := 120
	If nY = 1 
		cDet	:= " Tot   %"
	Else
		cDet	:= Transform(nTotal, cPict) + space(1)
		cDet 	+=Transform( (nTotal / nTotGer )* 100,cPictPerc) +space(1) 
		cDet	+=If(nY=2,"<30",if(nY=3,"30/60",">60") )
	Endif	
	Impr( cDet, "C",,,nCol,.T.)
	nTotal 	:= 0
	nCol	:= 0
Next nY 
fImprTotLinha(nTotGer)

Return(aArray)
  
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLSR813   �Autor  �Microsiga           � Data �  07/12/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function  fATraso(aAtraso)
Local nX	:= 0

/*��������������������������������������������������������������������������Ŀ
  � Beneficiarios com mais de 60 minutos de espera                           �
  ���������������������������������������������������������������������������� */
Impr("","C")
Impr( OemToansi(STR0007), "C",,,03,.T.)
Impr(__PrtThinLine() ,"C")
Impr( OemToansi(STR0008), "C",,,03,.T.)
Impr(__PrtThinLine() ,"C")
For nX := 1 to Len(aAtraso)
	Impr(aAtraso[nx] ,  "C",,,03,.T. ) 
Next nX


Return(nil)
/*
  00   01   02  03    05   06   07   08   09   10   11   12   13   14   15   16   17   18   19   20   21   22   23  Tot   % 
9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 999
9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 999
*/


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fAnalitico�Autor  �Microsiga           � Data �  07/12/03   ���
�������������������������������������������������������������������������͹��
���Desc.     � Relaciona Tempo de Espera Modo Analitico                   ���
���          � Mensal com  totais por Unidade e total Geral               ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fAnalitico()
Local   cOperadora		:= ""
Local   cUnidade		:= ""  
Local   cMedico			:= ""
Local   cDet     		:= ""
Local   cNomeUnid		:= ""
Local   nPos			:= 0
Local   nMinAtraso		:= 0
Local   aAtraso			:= {}

cOperadora	:= 	BBDTrb->BBD_CODINT
While !BBDTrb->(Eof()) .and. BBDTrb->BBD_CODINT = cOperadora
	/*��������������������������������������������������������������������������Ŀ
	  � Monta a tabela do intervalo de horas                                     �
	  ���������������������������������������������������������������������������� */
	aDados	:= fMontaTabHora()
	cOperadora	:= 	BBDTrb->BBD_CODINT
	cData    	:=  BBDTrb->BBD_DATA
	While !BBDTrb->(Eof()) .and. BBDTrb->BBD_CODINT + BBDTrb->BBD_DATA   == cOperadora + cData
		cOperadora	:= 	BBDTrb->BBD_CODINT
		cData		:=  BBDTrb->BBD_DATA
		cUnidade	:=  BBDTrb->BBD_CODLOC
		cNomeUnid	:= fDesc("BD1", cOperadora + cUnidade ,"BD1_DESLOC") 
	   	/*��������������������������������������������������������������������Ŀ
		  � Exibe mensagem...                                                  �
		  ����������������������������������������������������������������������*/
		MsProcTXT("Imprimindo " +  cUnidade + "-" +substr( cNomeUnid,15) + "..." )	

		While !BBDTrb->(Eof()) .and. BBDTrb->(BBD_CODINT + BBD_DATA +BBD_CODLOC)  == cOperadora+ cData + cUnidade
			nMinAtraso := fVerAtraso()
			nPos := ascan(aDados,  {|x| x[1] == substr(BBDTrb->BBD_HORA,1,2)}  )
			If nPos > 0
				If nMinatraso > 0 .and. nMinAtraso <= 30
                	aDados[nPos,2] :=   aDados[nPos,2] + 1
				ElseIf nMinAtraso > 30 .and. nMinAtraso <=60
                	aDados[nPos,3] :=   aDados[nPos,3] + 1
				ElseIf nMinAtraso > 60
					aDados[nPos,4] :=   aDados[nPos,4] + 1
					fMaior60() 											//-- Verifica se Atraso > 60
				Endif
			Endif
			BBDTrb->(dbSkip())
		Enddo
		Impr("Dia : "+ ConvertData(cData) +space(1) + " Unidade : " + cUnidade + space(1) + fDesc("BD1", cOperadora + cUnidade ,"BD1_DESLOC") ,"C",,,00,.T.)
		fImpr()
		aDados	:= fMontaTabHora()
	Enddo 
	fImpTotal("1",ConvertData(cData ))
	aTotDiaAllUni	:= fMontaTabHora()	//-- Total por Dia de Todas as Unidades
Enddo
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fSintetico�Autor  �Microsiga           � Data �  07/12/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Relaciona Tempo de Espera Modo Sintetico                    ���
���          �Diario com  totais por dia de Cada Unidade                  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static function  fSintetico()
Local   cOperadora		:= ""
Local   cUnidade		:= ""  
Local   cNomeUnid		:= ""
Local   cDet     		:= ""
Local   nPos			:= 0
Local   nMinAtraso		:= 0
Local   aAtraso			:= {}

//BBD_FILIAL + BBD_CODINT + BBD_CODLOC + BBD_CODESP + BBD_CODIGO"

cOperadora	:= 	BBDTrb->BBD_CODINT
While !BBDTrb->(Eof()) .and. BBDTrb->BBD_CODINT = cOperadora
	/*��������������������������������������������������������������������������Ŀ
	  � Monta a tabela do intervalo de horas                                     �
	  ���������������������������������������������������������������������������� */
	aDados	:= fMontaTabHora()
	cOperadora	:= 	BBDTrb->BBD_CODINT
	cUnidade	:=  BBDTrb->BBD_CODLOC                   
	cNomeUnid	:= fDesc("BD1", cOperadora + cUnidade ,"BD1_DESLOC") 
   	/*��������������������������������������������������������������������Ŀ
	  � Exibe mensagem...                                                  �
	  ����������������������������������������������������������������������*/
	MsProcTXT("Imprimindo " +  cUnidade + "-" +substr( cNomeUnid,15) + "..." )	
	While !BBDTrb->(Eof()) .and. BBDTrb->BBD_CODINT + BBDTrb->BBD_CODLOC  == cOperadora + cUnidade
		nMinAtraso := fVerAtraso()
		nPos := ascan(aDados,  {|x| x[1] == substr(BBDTrb->BBD_HORA,1,2)}  )
		If nPos > 0
			If nMinatraso > 0 .and. nMinAtraso <= 30
				aDados[nPos,2] :=   aDados[nPos,2] + 1	
			ElseIf nMinAtraso > 30 .and. nMinAtraso <=60
               	aDados[nPos,3] :=   aDados[nPos,3] + 1	
			ElseIf nMinAtraso > 60
				aDados[nPos,4] :=   aDados[nPos,4] + 1
				fMaior60() 											//-- Verifica se Atraso > 60
			Endif
		Endif
		BBDTrb->(dbSkip())
	Enddo
	Impr( cUnidade + space(1) + cNomeUnid ,"C",,,00,.T.)
	fImpr()
	aDados	:= fMontaTabHora()
	
Enddo

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fMaior60()�Autor  �Microsiga           � Data �  07/12/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se Atraso > 60 Minutos                             ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function  fMaior60()

Local cDet 		:= ""
Local cNomeMed	:= ""
Local cDescEspec:= ""

/*
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
" Codigo Medico                    Espec           Codigo                 Paciente              Cheg    Atd   Marc   Data"
  999999 xxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxx #.###.####.######-##-# xxxxxxxxxxxxxxxxxxxx 99:99  99:99  99:99   99/99/9999
*/

If 	nMaior60 = 1
	cNomeMed	:= substr(fDesc("BAU", BBDTrb->BBD_CODIGO, "BAU_NOME"),1,25)
	cDescEspec:= LEFT(fDesc("BAQ", BBDTrb->(BBD_CODINT+BBD_CODIGO),"BAQ_DESCRI"),15)	
	cDet	:= BBDTrb->BBD_CODIGO  + space(1) + cNomeMed     + space(1) 			//-- Medico
	cDet	+= cDescEspec          + space(1) 										//-- Especialidade Medica
	cDet	+= BBDTrb->(transform(BBD_CODPAC ,"@R #.###.####.######-##-#")+ space(1)+ Left(BBD_NOME,20)) + space(1) 		//-- Paciente
	cDet	+= BBDTrb->(BBD_HORCHE  + space(2)+ BBD_HORENT )        + space(2)		//-- Hor Chegada e Hor Atd
	cDet	+= BBDTrb->(BBD_HORA)   + space(3) 									//-- Hora Consulta 
	cDet	+= ConvertData(BBDTrb->(BBD_DATA) ) 									//-- Data da consulta
	aadd(aAtraso,cDet )
Endif
Return(Nil) 

