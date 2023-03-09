#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'Tbiconn.ch' 

#define  CABERJ   '01'
#define  INTEGRAL '02'

/*------------------------------------------------------------------------- 
| Programa  | calcdtlim |Autor  | Otavio Pinto        | Data |  01/10/2012 |
|--------------------------------------------------------------------------|
| Desc.     | Calcula Data Limite do usuario.                              |
|           | Usados a TABELA: ZDL                                         |
|           | Chamada : no campo BA1_DATINC                                |
|--------------------------------------------------------------------------|
|           |            *** N O V A     V E R S A O ****                  | 
|--------------------------------------------------------------------------|
| Uso       | inclusao/alteracao de beneficiario                           |
|--------------------------------------------------------------------------|
|Formulas   | nZDLANOS  := INT( 24 anos * 365.25 dias ) = 8766 dias        |
|Exemplo    | nZDLMESES := INT( 6 meses * 30) - 28 = 152,5 -> 5 meses      | 
|--------------------------------------------------------------------------|
|           | Eu estava usando o campo BA1_CONEMP como sendo Contrato,     |
|           | porem o Bianchini me mostrou que na CABERJ o Contrato eh     |
|           | lido pelo campo BA1_CODEMP.                                  |
|           |                                                              | 
|           | Regra:                                                       |
|           |------------------------------------------------------------- |
|           |     TODOS     |  AGREGADOS  |    ART.30    |     ART.31      |
|           |------------------------------------------------------------- |
|           |    24 anos    |             |              |    24 anos      |
|           |      Dep      |      0      |   Mensagem   |      Dep        |
|           |                                                              | 
|--------------------------------------------------------------------------|
|26/09/2014 | Reescrita a rotina de calculo da Data Limite, de modo a per- |
|   OSP     | mitir ser parametrizada pela tabela ZDL. Assim,novas empresas|
|           | serão configuradas pelo proprio usuário.                     |
 -------------------------------------------------------------------------*/

user function CalcDtLim()      

local fdia           := {'31','28','31','30','31','30','31','31','30','31','30','31'}  
Local aArea			 := GetArea()                  

private cCRLF        := chr(13)+chr(10)
private cEmpresa     := SM0->M0_CODIGO

private dDatInic     := M->BA1_DATINC
private cBA1_CODINT  := M->BA3_CODINT 
private cBA1_CODEMP  := M->BA3_CODEMP
private cBA1_CONEMP  := M->BA3_CONEMP
private cBA1_VERCON  := M->BA3_VERCON
private cBA1_SUBCON  := M->BA3_SUBCON
private cBA1_VERSUB  := M->BA3_VERSUB
private cBA1_TIPUSU  := M->BA1_TIPUSU

private dDatNasc     := CtoD("")

private _cAviso      := "Atencao !"

private cNReduz      := ""
private cArt30_31    := ""

private _aTexto      := {}         
private nIdade       := 0

private cLinha       := ""
private cSql         := ""
private cAlias       := "TMP"
private dDatLimite   := CtoD("")
private cTexto       := ""

/*NOVAS VARIAVEIS*/
private nZDLANOS    := 0
private nZDLMESES   := 0
private dMeses      := CtoD("")
private dAanos      := CtoD("") 
private dSegGar     := CtoD("")

private cArea        := Alias()
private dDatNasc     := CtoD("")

dbSelectArea("BTS")
DbSetOrder(1)
DbGotop()
if MsSeek(xFilial("BTS")+M->BA1_MATVID) 
   dDatNasc := BTS->BTS_DATNAS
endif

cSql := ""
cSql += "SELECT * FROM " + RetSqlName("BQC")           + cCRLF
cSql += " WHERE BQC_FILIAL = '" + xFilial("BQC") + "'" + cCRLF
cSql += "   AND BQC_CODINT = '" + M->BA3_CODINT  + "'" + cCRLF
cSql += "   AND BQC_CODEMP = '" + M->BA3_CODEMP  + "'" + cCRLF
cSql += "   AND BQC_NUMCON = '" + M->BA3_CONEMP  + "'" + cCRLF
cSql += "   AND BQC_VERCON = '" + M->BA3_VERCON  + "'" + cCRLF
cSql += "   AND BQC_SUBCON = '" + M->BA3_SUBCON  + "'" + cCRLF
cSql += "   AND BQC_VERSUB = '" + M->BA3_VERSUB  + "'" + cCRLF
cSql += "   AND D_E_L_E_T_ = ' ' " 					   + cCRLF

If Select(cAlias) > 0 
   (cAlias)->( dbCloseArea() )
   cAlias := "TMP"  
Endif

dbUseArea(.T., "TOPCONN", TcGenQry(,, cSQL), cAlias, .T., .F.)                        

(cAlias)->(dbGotop())

//X:= (cAlias)->( RECCOUNT() )
	
If (cAlias)->(!EOF())
	cNReduz   := (cAlias)->(BQC_DESCRI)
	cArt30_31 := (cAlias)->(BQC_YSTSCO)
Endif
	
/*
dbSelectArea("BQC")
DbSetOrder(1)
if MsSeek(xFilial("BQC")+M->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)) 
   cNReduz   := BQC->BQC_DESCRI
   cArt30_31 := BQC->BQC_YSTSCO
endif	
*/

//dbSelectArea(cArea)

nIdade   := int( (dDataBase - dDatNasc) / 365 )

begin sequence

	if Empty(dDatNasc)
	   Alert("Este associado está sem a data de nascimento no Cadastro de VIDAS... Verificar !!", "A T E N C A O") 
	   break
	endif   
	  
	cSql := ' SELECT ZDL_FILIAL ' + cCRLF
	cSql += '      , ZDL_CODINT ' + cCRLF
	cSql += '      , ZDL_CODEMP ' + cCRLF
	cSql += '      , ZDL_CONEMP ' + cCRLF
	cSql += '      , ZDL_VERCON ' + cCRLF
	cSql += '      , ZDL_SUBCON ' + cCRLF
	cSql += '      , ZDL_VERSUB ' + cCRLF
	cSql += '      , ZDL_TIPUSU ' + cCRLF 
	cSql += '      , ZDL_GRAUPA ' + cCRLF
	cSql += '      , ZDL_ANO    ' + cCRLF 
	cSql += '      , ZDL_MESES  ' + cCRLF
	cSql += '      , ZDL_DTLIM ' + cCRLF
	cSql += '      , ZDL_ART30 ' + cCRLF
	cSql += '      , ZDL_ART31 ' + cCRLF
	cSql += '      , ZDL_AGREG ' + cCRLF
	cSql += '      , ZDL_MENSAG ' + cCRLF
	cSql += ' FROM '+RetSqlName("ZDL") + cCRLF 
	cSql += " WHERE D_E_L_E_T_ = ' ' " + cCRLF
	cSql += "   AND ZDL_FILIAL = ' ' " + cCRLF
	cSql += "   AND ZDL_CODINT = '"+ cBA1_CODINT +"' " + cCRLF
	cSql += "   AND ZDL_CODEMP = '"+ cBA1_CODEMP +"' " + cCRLF
	cSql += "   AND ZDL_CONEMP = '"+ cBA1_CONEMP +"' " + cCRLF
	cSql += "   AND ZDL_VERCON = '"+ cBA1_VERCON +"' " + cCRLF
	cSql += "   AND ZDL_SUBCON = '"+ cBA1_SUBCON +"' " + cCRLF
	cSql += "   AND ZDL_VERSUB = '"+ cBA1_VERSUB +"' " + cCRLF 
	cSql += "   AND ZDL_TIPUSU = '"+ cBA1_TIPUSU +"' " + cCRLF
	cSql += " ORDER BY ZDL_FILIAL , ZDL_CODINT , ZDL_CODEMP , ZDL_CONEMP , ZDL_VERCON , ZDL_SUBCON , ZDL_VERSUB "
	
	Memowrit( "C:\TEMP\CALCDTLIM.sql", cSQL )
	
	If Select(cAlias) > 0 
	   (cAlias)->(dbCloseArea())
	   cAlias := "TMP" 
	Endif
	
	dbUseArea(.T., "TOPCONN", TcGenQry(,, cSQL), cAlias, .T., .F.)                        
	
	(cAlias)->(dbGotop())

	//X:= TMP->( RECCOUNT() )
	
	While (cAlias)->(!Eof())
	
	   /*NOVAS VARIAVEIS*/
	   nZDLANOS     := INT( (cAlias)->ZDL_ANO * 365.25 )
	   nZDLMESES    := INT( (cAlias)->ZDL_MESES * 30 ) //- 28 
	
	    do case
	       /*-----------------------------------------------------------------------
	       | C A B E R J                                                            |
	        -----------------------------------------------------------------------*/
	       case cEmpresa == CABERJ
	
	            do case
	               case (cAlias)->ZDL_TIPUSU == cBA1_TIPUSU
	                    If (cAlias)->ZDL_DTLIM == "1"
	                       Do Case
	                          Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  <> "1" .and. (cAlias)->ZDL_AGREG <> "1"
							       if M->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
								      dDatLimite := CTOD( If( Mod(Year((dDatNasc + nZDLANOS)),4)=0 .And. Month( (dDatNasc + nZDLANOS) ) = 2 , '29', fdia[Month( (dDatNasc + nZDLANOS) )] )+ "/" +;
												    strzero(month((dDatNasc + nZDLANOS)),2) +"/"+strzero(year((dDatNasc + nZDLANOS)),4) ) 
	                               endif 
	                               If !Empty( (cAlias)->ZDL_MENSAG )
	                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                               Endif   
	                          
	                          Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES > 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31 <> "1" .and. (cAlias)->ZDL_AGREG <> "1" 
	                               dDatLimite := CTOD( If( Mod(Year(dDatInic + nZDLMESES),4)=0 .And. Month( dDatInic + nZDLMESES ) = 2 , '29', fdia[Month( dDatInic + nZDLMESES )] )+ "/" +;
	                                             strzero(month(dDatInic + nZDLMESES),2) +"/"+strzero(year(dDatInic + nZDLMESES),4) ) 
	                               If !Empty( (cAlias)->ZDL_MENSAG )
	                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                               Endif   
	
	                          Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES > 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  == "1" .and. (cAlias)->ZDL_AGREG <> "1" 
				                   if M->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) 
	                                  dSegGar    := CTOD(  SUBSTR(DTOS(dDatInic),7,2)+"/"+SUBSTR(DTOS(dDatInic),5,2)+"/"+SUBSTR(DTOS(dDatInic),1,4)  ) + nZDLMESES
	                                  dDatLimite := CTOD( If( Mod(Year(dSegGar),4)=0 .And. Month( dSegGar ) = 2 , '29', fdia[Month( dSegGar )] )+ "/" +;
									                      strzero(month(dSegGar),2) +"/"+strzero(year(dSegGar),4) ) 																				
	                               Endif   
	                               If !Empty( (cAlias)->ZDL_MENSAG )
	                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                               Endif   
	                                             
	                          Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES > 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  <> "1" .and. (cAlias)->ZDL_AGREG <> "1" 
				                   if M->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
	                                  dMESES  := CTOD(  SUBSTR(DTOS(dDatInic),7,2)+"/"+SUBSTR(DTOS(dDatInic),5,2)+"/"+SUBSTR(DTOS(dDatInic),1,4)  ) + nZDLMESES
	                                  dANOS   := dDatNasc + nZDLANOS
	                                  dSegGar := if (dMESES < dANOS, dMESES, dANOS )			 							   
	                                  dDatLimite := CTOD( If( Mod(Year(dSegGar),4)=0 .And. Month( dSegGar ) = 2 , '29', fdia[Month( dSegGar )] )+ "/" +;
									                      strzero(month(dSegGar),2) +"/"+strzero(year(dSegGar),4) ) 																				
	                               Endif   
	                               If !Empty( (cAlias)->ZDL_MENSAG )
	                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                               Endif   
	                                
	                          Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART30  == "1" .AND. (cAlias)->ZDL_ART31  <> "1" .and. (cAlias)->ZDL_AGREG <> "1" 
	                               If !Empty( (cAlias)->ZDL_MENSAG )
	                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                               Endif   
	                              
	                          Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  == "1" .and. (cAlias)->ZDL_AGREG <> "1" 
							       if M->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
								      dDatLimite := CTOD( If( Mod(Year((dDatNasc + nZDLANOS)),4)=0 .And. Month( (dDatNasc + nZDLANOS) ) = 2 , '29', fdia[Month( (dDatNasc + nZDLANOS) )] )+ "/" +;
												    strzero(month((dDatNasc + nZDLANOS)),2) +"/"+strzero(year((dDatNasc + nZDLANOS)),4) ) 
	                               endif 
	                               If !Empty( (cAlias)->ZDL_MENSAG )
	                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                               Endif   
	
	                          Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  <> "1" .and. (cAlias)->ZDL_AGREG == "1" 
	                               If AT( "AGREG", cNReduz ) > 0 
	                                  dDatLimite := CtoD("")
	                               endif                    
	                               If !Empty( (cAlias)->ZDL_MENSAG )
	                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                               Endif   
	                               
	                       Endcase
	                    Else    
	                       dDatLimite := CtoD("")
	                    Endif
	            Otherwise                    
	                 dDatLimite := CtoD("")
	            Endcase
	
	       /*-----------------------------------------------------------------------
	       | I N T E G R A L                                                        |
	        -----------------------------------------------------------------------*/           
	       case cEmpresa == INTEGRAL
	            do case              
	                case (cAlias)->ZDL_TIPUSU == cBA1_TIPUSU
	                    If (cAlias)->ZDL_DTLIM == "1"
	                        Do Case                                                     
	                           Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART30  == "1" .AND. cArt30_31 == "01" 
	                                If !Empty( (cAlias)->ZDL_MENSAG )
	                                   MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                                Endif   
	                                dDatLimite := CtoD("") 
	                                
	                           Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART31  == "1" .AND. cArt30_31 <> "01" 
	                                if M->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
	                                   dDatLimite := CTOD( If( Mod(Year((dDatNasc + nZDLANOS)),4)=0 .And. Month( (dDatNasc + nZDLANOS) ) = 2 , '29', fdia[Month( (dDatNasc + nZDLANOS) )] )+ "/" +;
	                                                 strzero(month((dDatNasc + nZDLANOS)),2) +"/"+strzero(year((dDatNasc + nZDLANOS)),4) ) 
	                                endif 						                                                                           
	                                If !Empty( (cAlias)->ZDL_MENSAG )
	                                   MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                                Endif   
	
	                           Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART31  <> "1" .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_AGREG <> "1"
	                                if M->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
	                                   dDatLimite := CTOD( If( Mod(Year((dDatNasc + nZDLANOS)),4)=0 .And. Month( (dDatNasc + nZDLANOS) ) = 2 , '29', fdia[Month( (dDatNasc + nZDLANOS) )] )+ "/" +;
	                                                 strzero(month((dDatNasc + nZDLANOS)),2) +"/"+strzero(year((dDatNasc + nZDLANOS)),4) ) 
	                                endif 						                                                                           
	                                If !Empty( (cAlias)->ZDL_MENSAG )
	                                   MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                                Endif    
	
	                           Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. !cArt30_31 $ "01,02,"  .and. (cAlias)->ZDL_AGREG <> "1" .AND. (cAlias)->ZDL_ART30 <> "1" .AND. (cAlias)->ZDL_ART31 <> "1"
	                                if M->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
	                                   dDatLimite := CTOD( If( Mod(Year((dDatNasc + nZDLANOS)),4)=0 .And. Month( (dDatNasc + nZDLANOS) ) = 2 , '29', fdia[Month( (dDatNasc + nZDLANOS) )] )+ "/" +;
	                                                 strzero(month((dDatNasc + nZDLANOS)),2) +"/"+strzero(year((dDatNasc + nZDLANOS)),4) ) 
	                                endif 						                                 
	                                If !Empty( (cAlias)->ZDL_MENSAG )
	                                   MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                                Endif   
	                                
	                           Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES == 0 .and. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  <> "1" .AND. !cArt30_31 $ "01,02" .and. (cAlias)->ZDL_AGREG == "1"
	                                If AT( "AGREG", cNReduz ) > 0 
	                                   dDatLimite := CtoD("")
	                                endif                   
	                                If !Empty( (cAlias)->ZDL_MENSAG )
	                                   MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                                Endif   
	                                
	                           // ---------- meses
	                          Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES > 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  <> "1" .and. (cAlias)->ZDL_AGREG <> "1" 
				                   if M->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) 
	                                  dSegGar    := CTOD(  SUBSTR(DTOS(dDatInic),7,2)+"/"+SUBSTR(DTOS(dDatInic),5,2)+"/"+SUBSTR(DTOS(dDatInic),1,4)  ) + nZDLMESES
	                                  dDatLimite := CTOD( If( Mod(Year(dSegGar),4)=0 .And. Month( dSegGar ) = 2 , '29', fdia[Month( dSegGar )] )+ "/" +;
									                      strzero(month(dSegGar),2) +"/"+strzero(year(dSegGar),4) ) 																				
	                               Endif   
	                               If !Empty( (cAlias)->ZDL_MENSAG )
	                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                               Endif   
	                          // ---------- anos e meses                                     
	                          Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES > 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  <> "1" .and. (cAlias)->ZDL_AGREG <> "1" 
				                   if M->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
	                                  dMESES  := CTOD(  SUBSTR(DTOS(dDatInic),7,2)+"/"+SUBSTR(DTOS(dDatInic),5,2)+"/"+SUBSTR(DTOS(dDatInic),1,4)  ) + nZDLMESES
	                                  dANOS   := dDatNasc + nZDLANOS
	                                  dSegGar := if (dMESES < dANOS, dMESES, dANOS )			 							   
	                                  dDatLimite := CTOD( If( Mod(Year(dSegGar),4)=0 .And. Month( dSegGar ) = 2 , '29', fdia[Month( dSegGar )] )+ "/" +;
									                      strzero(month(dSegGar),2) +"/"+strzero(year(dSegGar),4) ) 																				
	                               Endif   
	                               If !Empty( (cAlias)->ZDL_MENSAG )
	                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
	                               Endif   
	                                
	
	                                
	                        Otherwise        
	                             dDatLimite := CtoD("")   
	                        Endcase
	                    Else    
	                       dDatLimite := CtoD("")
	                    Endif
	            Otherwise                    
	                 dDatLimite := CtoD("")
	            Endcase
	
	    Endcase       
	    (cAlias)->(dbSkip())
	End    
    
end sequence

M->BA1_YDTLIM := dDatLimite 

RestArea(aArea)

return .t.



// Fim da rotina CALCDTLIM.PRW

/*---------------------------------------------------------------------------------------------------------------- 
| Alterar na tabela SX3010 e SX3020, os campos abaixo:                                                            | 
|                                                                                                                 |
| X3_ARQUIVO = BA1                                                                                                |
| X3_CAMPO   = BA1_GRAUPA                                                                                         |
| X3_ORDERM  = 25                                                                                                 |
| X3_VLDUSER = U_VldGrauPar((__cBA1)->BA1_GRAUPA)                                                                 |                                   
|-----------------------------------------------------------------------------------------------------------------|
| X3_ARQUIVO = BA1                                                                                                |
| X3_CAMPO   = BA1_DATINC                                                                                         |
| X3_ORDERM  = 27                                                                                                 |
| X3_VLDUSER = IIF(Inclui,IIF((__cBA1)->BA1_DATINC<((DDATABASE+1)-DAY(DDATABASE)),.F.,.T.),.T.)  .And. U_CalcDtLim()     |
|                                                                                                                 |
|                                                                                                                 |
 ----------------------------------------------------------------------------------------------------------------*/


User Function mbctstbqc()


dbSelectArea("BQC")
alert("oi1")
("BQC")->( DbSetOrder(1) )
alert("oi2")
if ("BQC")->( dbSeek(xFilial("BQC")+'00010001000000000001001000000001001' ))
alert("oi3")
   cNReduz   := ("BQC")->BQC_DESCRI
   cArt30_31 := ("BQC")->BQC_YSTSCO
endif

Return

