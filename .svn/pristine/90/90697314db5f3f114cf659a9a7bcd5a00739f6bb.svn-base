#include "PLSA090.ch" 
#include "PROTHEUS.CH"
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
STATIC oBrwPro                  
STATIC oBrwCri
STATIC oEncAut
STATIC __cDescri
STATIC __lAutoriz  := .F.
STATIC nHorIni     := 0
STATIC __cCodRdaP  := ""
STATIC __cTipo     := "1"
STATIC lInfRda	   := .F.
STATIC cCodLocPar  := ""
STATIC aAutFor     := {}
STATIC aDadCri     := {}
STATIC aCabCri     := {}
STATIC aTrbCri     := {}
STATIC aValAcuAut  := {}
STATIC bImpGuia    := {|| A090PosArq(), IIf(BEA->BEA_STATUS $"1,2,3,4" ,IIF(ExistBlock("PLSA090IMP") ,ExecBlock("PLSA090IMP",.F.,.F.,{"1"}) ,IIf(GetNewPar("MV_PLSTISS","1")=="1" ,PLSR430N({"1",lImpGuiDir}) ,PLSR430({"1",lImpGuiDir}))) ,(Help("",1,"PLSR430")))}
STATIC bImpG2      := {|| A090PosArq(), If(.T.,IF(ExistBlock("PLSA090IMP"),ExecBlock("PLSA090IMP",.F.,.F.,{"2"}),IIf(GetNewPar("MV_PLSTISS","1")=="1", PLSR430N({"2",lImpGuiDir}), PLSR430({"2",lImpGuiDir}))),(Help("",1,"PLSR430")))   }
STATIC aDadB43     := {}
STATIC aCabB43     := {}
STATIC aTrbB43     := {}
STATIC aCdCores    := {}
STATIC cDesQtdSol  := ""
STATIC cDesQtdAut  := ""

User Function uPLSA090PRO()
LOCAL lRet      := .F.           
LOCAL cFaces 	:= ""    
LOCAL cAliCab	:= PLSRetAut()[2]               
LOCAL cAliIte   := PLSRetAut()[3]

BR8->(DbSetOrder(1))
lRet := BR8->(MsSeek(xFilial("BR8")+&("M->"+cAliIte+"_CODPAD")+&("M->"+cAliIte+"_CODPRO") ))
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Odontologico															 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If PLSRetAut()[1] == "01"
	If lRet  
		M->BE2_DESPRO := Posicione("BR8",1,xFilial("BR8")+alltrim(M->BE2_CODPAD+M->BE2_CODPRO),"BR8_DESCRI")
		oBrwPro		  := PLRetOProO()
		oBrwCri       := PLRetOCriO()
		oEncAut       := PLRetOEnOd()
	Endif
Endif                                                                         
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Reembolso																 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If PLSRetAut()[1] == "03"
	If lRet  
		oBrwPro		  := Pl001ROp()
		oBrwCri       := Pl001RCr()
		oEncAut       := Pl001REn()
	Else
   		Help("",1,"REGNOIS")
   		Return(lRet)
	Endif
Endif                                                                         
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica se tem algum campo obrigatorio nao informado no cabecellho		 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If Type('oEncAut') <> 'U' 
	If !Obrigatorio(oEncAut:aGets,oEncAut:aTela)
	   Return(.F.)
	EndIf
Endif
	
If lRet
    //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Se eh reembolso sempre entra aqui										 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
    If PLSRetAut()[1] == "03"
		lRet := PLSA001Aut(M->B45_SEQUEN,M->B45_CODPAD,M->B45_CODPRO,M->B45_QTDPRO,;
	     				   "1",nil,cAliCab,nil,oBrwPro,oBrwCri,M->B44_CDPFRE,nil,nil,M->B44_PADINT,;
	     				   M->B44_PADCON,M->B44_GRPINT,nil,nil,nil,nil,nil,nil)
    ElseIf (BR8->(FieldPos("BR8_ODONTO")) > 0 .And. BR8->BR8_ODONTO = '1') .And. UPPER( Alltrim( FunName() ) ) $ "PLSA094C,PLSA094D"
	    
	    M->BE1_NUMLIB := M->B01_NUMLIB
    	
    	If ReadVar() == "M->BE2_QTDPRO" .And. Type('M->BE2_QTDSOL') <> 'U'
		   If M->BE2_QTDSOL <> M->BE2_QTDPRO
		   		lRet := PLA090CPMo()	
		   EndIf 
	    //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Estou no procedimento                           						 Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
		ElseIf ReadVar() == "M->BE2_CODPRO"                
			M->BE2_DENREG := Space(TamSx3("BE2_DENREG")[1])
			M->BE2_DESREG := Space(TamSx3("BE2_DESREG")[1])
			M->BE2_FADENT := Space(TamSx3("BE2_FADENT")[1])
			M->BE2_FACDES := Space(TamSx3("BE2_FACDES")[1])
		    //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁVerifica se tem dente a ser informado									 Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
    		B05->( DbSetORder(1) )//B05_FILIAL + B05_CODPAD + B05_CODPSA + B05_CODIGO + B05_TIPO
    		If !B05->( MsSeek( xFilial("B05")+&("M->"+cAliIte+"_CODPAD")+&("M->"+cAliIte+"_CODPRO") ) )
    			lRet := PLA090CPMo() 
			EndIf
	    //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁSe estou no dente ou regiЦo e nao existe face cadastrada					 Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
    	ElseIf ReadVar() == "M->BE2_DENREG" 
    		
    		BYL->(DbSetORder(1))//BYL_FILIAL + BYL_CODPAD + BYL_CODPSA + BYL_CODIGO + BYL_TIPO+BYL_FACE
    		If !BYL->( MsSeek( xFilial("BYL")+&("M->"+cAliIte+"_CODPAD")+&("M->"+cAliIte+"_CODPRO")+&("M->"+cAliIte+"_DENREG") ) )
    			lRet := PLA090CPMo() 
			EndIf
	    //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁSe estou na face															 Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
        ElseIf ReadVar() == "M->BE2_FADENT" 
        	lRet := PLA090CPMo()
        EndIf
    Else
	    lRet := PLSA090Aut(M->BE2_SEQUEN,M->BE2_CODPAD,M->BE2_CODPRO,M->BE2_QTDPRO,"1",nil,cAliCab,;
	     				   nil,oBrwPro,oBrwCri,M->BE1_CDPFRE,nil,nil,nil,nil,cFaces,nil,nil,;
	     				   nil,aDadB43,aCabB43,aTrbB43,nil,If(__cTipo=="2","S","E"),nil,nil,.F.)
	EndIf
Else
   Help("",1,"REGNOIS")
EndIf

//se for autorizaГЦo a quantidade solicitada vai ser igual a quantidade realizada
//desde que nao exista uma liberaГЦo 
If lRet .And. __cTipo == '1'
	If Type('M->BE1_NUMLIB') <> 'U' .and. Type('M->BE2_QTDPRO') <> 'U' .and. Type('M->BE2_QTDSOL') <> 'U' .and. Empty(M->BE1_NUMLIB) //ela nao eh oriunda de uma liberacao		
		M->BE2_QTDSOL := M->BE2_QTDPRO 		
	Endif
Endif
 
Return(lRet)