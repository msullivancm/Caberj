#Include "PROTHEUS.CH"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamada do relatório Crystal NUPTER³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function NUPTER

Private cCRPar      := "1;0;1;" 
Private cParam1     := "" 
Private cCrystal    := "NUPTER"   

/*Conjunto de opções para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde 
  x = vídeo(1) ou impressora(3) 
  y = Atualiza(0) ou não(1) os dados
  z = Número de cópias 
  w = Título do relatorio.
*/         
If !Pergunte(cCrystal,.T.)
 	 Return
Endif

If U_VlRelNupre(ALLTRIM(STR(MV_PAR03)),MV_PAR02+MV_PAR01+"01") //<< verificar esta chamada
   cParam1 :=  MV_PAR01+";"+MV_PAR02+";"+ALLTRIM(STR(MV_PAR03))
   cCRPar :="1;0;1;NUPTER" 
   CallCrys(cCrystal,cParam1,cCRPar)   
Else
  Aviso( "NUPTER","A T E N C A O! Seu cadastro nao permite acessar este local (Nupre) ou Relatorio nao disponivel no momento !! ",{ "Ok" }, 2 )
Endif 

Return  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamada do relatório Crystal AAGEXG³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function AAGEXC

Private cCRPar      := "1;0;1;" 
Private cParam1     := "" 
Private cCrystal    := "AAGEXC"   

/*Conjunto de opções para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde 
  x = vídeo(1) ou impressora(3) 
  y = Atualiza(0) ou não(1) os dados
  z = Número de cópias 
  w = Título do relatorio.
*/
If !Pergunte(cCrystal,.T.)
 	 Return
Endif

If U_VlRelNupre(ALLTRIM(STR(MV_PAR03)),MV_PAR02+MV_PAR01+"01")
   cParam1 :=  MV_PAR01+";"+MV_PAR02+";"+ALLTRIM(STR(MV_PAR03)) 
   cCRPar :="1;0;1;AAGEXC" 
   CallCrys(cCrystal,cParam1,cCRPar)   
Else
  Aviso( "AAGEXC","A T E N C A O! Seu cadastro nao permite acessar este local (Nupre) ou Relatorio nao disponivel no momento !! ",{ "Ok" }, 2 )
Endif 

Return  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamada do relatório Crystal SAAG15³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function SAAG15

Private cCRPar      := "1;0;1;" 
Private cParam1     := "" 
Private cCrystal    := "SAAG15"   

/*Conjunto de opções para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde 
  x = vídeo(1) ou impressora(3) 
  y = Atualiza(0) ou não(1) os dados
  z = Número de cópias 
  w = Título do relatorio.
*/

If !Pergunte(cCrystal,.T.)
 	 Return
Endif

If U_VlRelNupre(STR(MV_PAR01),MV_PAR02+"01")
   cParam1 :=  ALLTRIM(STR(MV_PAR01))+";"+MV_PAR02+";"+MV_PAR03
   cCRPar :="1;0;1;SAAG15" 
   CallCrys(cCrystal,cParam1,cCRPar)   
Else
  Aviso( "SAAG15","A T E N C A O! Seu cadastro nao permite acessar este local (Nupre) ou Relatorio nao disponivel no momento !! ",{ "Ok" }, 2 )
Endif 

Return  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamada do relatório Crystal EXTAAG³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function EXTAAG

Private cCRPar      := "1;0;1;" 
Private cParam1     := "" 
Private cCrystal    := "EXTAAG" 
Private cNupre      := ""    
Private cSQLTmp := ""    

/*Conjunto de opções para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde 
  x = vídeo(1) ou impressora(3) 
  y = Atualiza(0) ou não(1) os dados
  z = Número de cópias 
  w = Título do relatorio.
*/     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o Nupre do usuario                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !Pergunte(cCrystal,.T.)
 	 Return
Endif 

cSQLTmp := " SELECT RETORNA_NUCLEO_MS('"+SUBSTR(MV_PAR03,1,4)+"','"+SUBSTR(MV_PAR03,5,4)+"','"+SUBSTR(MV_PAR03,9,6)+"','"+SUBSTR(MV_PAR03,15,2)+"','"+MV_PAR01+MV_PAR02+"01') NUPRE "
cSQLTmp += " FROM DUAL "

PLSQUERY(cSQLTmp,"TRBBA1")
TRBBA1->(DbGoTop())
			
If !TRBBA1->(Eof())
  cNupre := TRBBA1->NUPRE
Endif    
TRBBA1->(DbCloseArea())

If U_VlRelNupre(cNupre,MV_PAR01+MV_PAR02+"01")
   cParam1 :=  MV_PAR01+";"+MV_PAR02+";"+MV_PAR03 
   cCRPar :="1;0;1;EXTAAG" 
   CallCrys(cCrystal,cParam1,cCRPar)   
Else
  Aviso( "EXTAAG","A T E N C A O! Seu cadastro nao permite acessar este local (Nupre) ou Relatorio nao disponivel no momento !! ",{ "Ok" }, 2 )
Endif 

Return  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Valida emissao rel. pelo Nupre     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function VlRelNupre(cNupre,cRef)   

Local lRet    := .F. 
Local cSQLTmp := ""    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ VERIFICA SE O USUARIO TEM NUPRE   ³
//³    EXCLUSIVO E SE ESTE TEM NA     ³
//³    REFERENCIA OS RELATORIOS LI-   ³
//³    BERADOS                        ³
//³  USUARIOS SEM NUPRE EXCLUSIVO     ³
//³  PODEM EMITIR A QUALQUER STATUS   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cSQLTmp := " SELECT PAO.PAO_STATUS  PAO_STATUS,BX4.BX4_YCDLOC BX4_YCDLOC"
cSQLTmp += " FROM "+RetSqlName("BX4")+" BX4, "+RetSqlName("PA6")+" PA6, "+RetSqlName("PAO")+" PAO "
cSQLTmp += " WHERE BX4.BX4_FILIAL = '"+xFilial("BX3")+"' "
cSQLTmp += " AND    BX4.BX4_CODOPE = '" + __CUSERID + "' "  
cSQLTmp += " AND    PA6.PA6_FILIAL = BX4_FILIAL "  
cSQLTmp += " AND    PA6.PA6_CODLOC = NVL(TRIM(BX4.BX4_YCDLOC),PA6.PA6_CODLOC) " 
cSQLTmp += " AND    PAO.PAO_NUPRE = '" + ALLTRIM(cNupre) + "' "  
cSQLTmp += " AND    PAO.PAO_FILIAL = PA6.PA6_FILIAL "  
cSQLTmp += " AND    PAO.PAO_NUPRE = PA6.PA6_CODNUP " 
cSQLTmp += " AND    PAO.PAO_COMPET = '" + cRef + "' "  
cSQLTmp += " AND    BX4.D_E_L_E_T_ = ' ' "  
cSQLTmp += " AND    PA6.D_E_L_E_T_ = ' ' "  
cSQLTmp += " AND    PAO.D_E_L_E_T_ = ' ' " 

//memowrite("c:\lixo\cSQLTmp.sql",cSQLTmp)

PLSQUERY(cSQLTmp,"TRBBA1")
TRBBA1->(DbGoTop())
			
If !TRBBA1->(Eof())
  lRet := ((TRBBA1->PAO_STATUS $ "A/P") .OR. (Empty(TRBBA1->BX4_YCDLOC)))
Endif    
TRBBA1->(DbCloseArea())


Return lRet