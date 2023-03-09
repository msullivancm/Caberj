#INCLUDE 'TOPCONN.CH'
#INCLUDE 'PROTHEUS.CH' 
                                                                                                                                 
#INCLUDE "PLSMGER.CH"                                                                                   
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch' 

#DEFINE CRLF CHR(13) + CHR(10) 

//Leonardo Portella - 30/09/15                                                                
//Ponto de entrada na validacao do registro do SIB

User Function PLS782DAD

Local aArea782		:= GetArea()
Local c_TpoInc 		:= PARAMIXB[1]
Local a_Reg			:= PARAMIXB[2]
Local cDatContra 
Local cDatCanc
Local cDatContrSIB
Local cDatReat
Local cDatCanSIB
Local lTitInc		:= .F.
Local lEnvia		:= .T.
Local c_CCO			:= ''
Local c_Matric		:= ''
Local cAlEnviar
Local cQry
Local cCargaInicio	

Local aAreasx6 := GetArea()     

private cSibEnv := GETMV("MV_SIBENV") // 1 - Sib SIM  , 0 - Sib NAO  
Private SIBINC  := GETMV("MV_SIBINC") // 1 - SIM FAZ  , 2 - NAO NAO FAZ   
Private SIBRET  := GETMV("MV_SIBRET") // 1 - SIM FAZ  , 2 - NAO NAO FAZ   
Private SIBEXC  := GETMV("MV_SIBEXC") // 1 - SIM FAZ  , 2 - NAO NAO FAZ   
Private SIBREA  := GETMV("MV_SIBREA") // 1 - SIM FAZ  , 2 - NAO NAO FAZ    
Private SIBFIM  := GETMV("MV_SIBFIM") // 1 - SIM FAZ  , 2 - NAO NAO FAZ   
Private SIBMUC  := 2  //GETMV("MV_SIBMUC") // 1 - SIM FAZ  , 2 - NAO NAO FAZ   
private DtString  := substr(dtos(date()),1,8)

private cComp     := Iif(substr(dtos(date()),5,2)=='01',STRZERO((VAL(substr(dtos(date()),1,4))-1),4),substr(dtos(date()),1,4))+Iif(substr(dtos(date()),5,2)=='01','12',STRZERO((VAL(substr(dtos(date()),5,2))-1),2)) 

Private adADcCOc  :={date()}   
Private adADcCOi  :={}   
Private adADcCOcM :={}   
Private adADcCOiM :={}        
Private adADcCOcE :={}   
Private adADcCOiE :={}  
Private adADMat   :={}  
PRIVATE cEmp      := iif (cEmpAnt == '01','CABERJ','INTEGRAL')  
private cTpSib    := Iif(substr(dtos(date()),7,2) < '06' , 'Sib Mensal', 'Sib Global')  
//private cTpSib    :=  'Sib Global' // retirar - altamiro	 


//CaregaVet() // retirado temporariamente 


Do Case
	
	Case ( c_TpoInc == '1' )//Inclusão 
	
		If ( len(a_Reg) >= 29 ) 
		
			cDatContra 	:= StoD(Left(a_Reg[23],4) + Substr(a_Reg[23],6,2) + Right(a_Reg[23],2))
			
			//Se a matricula atual for diferente da matricula do titular trata-se de dependente. A negação é o titular
			lTitInc 	:= !( !empty(a_Reg[10]) .and. ( a_Reg[1] <> a_Reg[10] ) )
			
			If ( cEmpAnt == '02' ) .and. ( AllTrim(a_Reg[20]) == '460940099' )
		
				//Chamado ID 25767: Plano Essencial 20 E (0069) - 460940099: Proibida a comercialização no período abaixo. Dependentes e art 30/31 permitidos.
				                   
				If ( cDatContra >= StoD('20151119') ) .and. ( cDatContra < StoD('20160304') ) 
			
					If lTitInc .and. !lArt30_31(a_Reg[1])
						
						a_Reg[29] := .F.//Desconsidera o registro
						
					EndIf
					
				EndIf
				
			EndIf
			
			If !empty(a_Reg[8]) .and. empty(a_Reg[9])//DN sem CNS
				a_Reg[29] := .F.//Desconsidera o registro
			ElseIf cDatContra > mv_par06 //Crítica 1205 - Data de contratacao maior que a competencia
				a_Reg[29] := .F.//Desconsidera o registro
			EndIf 
			
			//Se a matricula atual for diferente da matricula do titular trata-se de dependente.			
			If !lTitInc
			
				//01/12/15 - Critica 1802. O beneficiário titular pode não ter sido enviado ainda, por isso 
				//não envia o dependente nesta remessa do SIB para ser enviada quando o titular estiver OK
				/*If !u_lTitularOk(a_Reg[1], a_Reg[10],.T.)
					a_Reg[29] := .F.//Desconsidera o registro
				EndIf*/
				
			EndIf

//		   fTratEnd('Inc')  trata tipo de endereço tratar no proximo sib
			
			lEnvia := a_Reg[29]  //Inclusão 
		
		EndIf

	Case ( c_TpoInc == '2' )//Retificação 
	
		If ( len(a_Reg) >= 33 )
		
//		   fTratEnd('Ret')  trata tipo de endereço
		 //tratamento para municipio tipo end residencial  
		
		 //   a_Reg[12] := "2"  // tipo de endereço residencias
		 //   a_Reg[19] := "0"  // residente exterior 
		    a_Reg[20] := ''  // cod do numicipio 
		
			cDatContra := StoD(Left(a_Reg[24],4) + Substr(a_Reg[24],6,2) + Right(a_Reg[24],2))
			
			If empty(a_Reg[1])//Sem CCO (Invalido no schema)
				a_Reg[33] := .F.//Desconsidera o registro
			ElseIf cDatContra > mv_par06 //Crítica 1205 - Data de contratacao maior que a competencia
				a_Reg[33] := .F.//Desconsidera o registro
			EndIf

		  	lEnvia := a_Reg[33]                                     
		EndIf
		
		
	Case ( c_TpoInc == '3' )//Cancelamento
	
		If ( len(a_Reg) >= 5 ) 
		
			cDatCanc := Replace(a_Reg[3],'-','')
			                                                                  
			If empty(a_Reg[1])//Sem CCO (Invalido no schema)
				a_Reg[5] := .F.//Desconsidera o registro
			Else
			
				//SIBAO
				If empty(a_Reg[4]) .or. ( AllTrim(a_Reg[4]) == '01' ) //Motivo bloqueio
					a_Reg[4] := '42' //Desligamento da empresa
				EndIf
			
				cDatContrSIB := cGetCpoSIB(a_Reg[1],'SIB_DATCON')
				
				//Crítica 3104 - Data de cancelamento deve ser posterior ou igual à data de contratação.
				If !empty(cDatContrSIB) .and. ( cDatContrSIB > cDatCanc )
					
					a_Reg[3] := Left(cDatContrSIB,4) + '-' + Substr(cDatContrSIB,5,2) + '-' + Right(cDatContrSIB,2)
		  
							//a_Reg[5] := .F.//Desconsidera o registro
					
				EndIf
				
			EndIf 

			lEnvia := a_Reg[5] 
			
		EndIf

	Case ( c_TpoInc == '4' )//Reativação 
	
		If ( len(a_Reg) >= 4 )
		
			cDatReat := Replace(a_Reg[3],'-','')
			
			If empty(a_Reg[1])//Sem CCO (Invalido no schema)
				a_Reg[4] := .F.//Desconsidera o registro 
			Else
			
				cDatCanSIB := cGetCpoSIB(a_Reg[1],'SIB_DATCAN')
				
				If cDatCanSIB > cDatReat
					//Crítica 2004 - Data de Reativação deve ser posterior ou igual à Data de Cancelamento existente no cadastro em reativação.
					a_Reg[4] := .F.//Desconsidera o registro     
				EndIf
				
			EndIf

			lEnvia := a_Reg[4] 
			 
		EndIf
	
	Case ( c_TpoInc == '5' )//Mudanca Contratual 
	
		If ( len(a_Reg) >= 13 )
		
			a_Reg[13] := .F.//Desconsidera o registro
			
		EndIf

		lEnvia := a_Reg[13] 
				
EndCase

//ENVIO EXCEPCIONAL SOMENTE...   

/*
LOCAL SIBINC := GETMV("MV_SIBINC") // 1 - SIM FAZ  , 2 - NAO NAO FAZ   
LOCAL SIBRET := GETMV("MV_SIBRET") // 1 - SIM FAZ  , 2 - NAO NAO FAZ   
LOCAL SIBEXC := GETMV("MV_SIBEXC") // 1 - SIM FAZ  , 2 - NAO NAO FAZ   
LOCAL SIBREA := GETMV("MV_SIBREA") // 1 - SIM FAZ  , 2 - NAO NAO FAZ   
LOCAL SIBMUC := GETMV("MV_SIBMUC") // 1 - SIM FAZ  , 2 - NAO NAO FAZ   

 */
Do Case

	Case ( c_TpoInc == '1' .AND. SIBINC == 2 )//Inclusão 
	
		If ( len(a_Reg) >= 29 )
			a_Reg[29] 	:= .F.//Desconsidera o registro  
			lEnvia 		:= .F.
		EndIf

	Case ( c_TpoInc == '2' .AND. SIBRET == 2 )//Retificação 
	
		If ( len(a_Reg) >= 33 )
			a_Reg[33] 	:= .F.//Desconsidera o registro  
			lEnvia 		:= .F.
		EndIf
  
	Case ( c_TpoInc == '3' .AND. SIBEXC == 2)//Exclusao 
	
		If ( len(a_Reg) >= 5 )
			//a_Reg[5] 	:= .F.//Desconsidera o registro   
 		   	a_Reg[5] 	:= .F.//Desconsidera o registro  
			lEnvia 		:= .F.
		EndIf
	
	Case ( c_TpoInc == '4' .AND. SIBREA == 2 )//Reativação 
	
		If ( len(a_Reg) >= 4 )
			a_Reg[4] 	:= .F.//Desconsidera o registro  
			lEnvia 		:= .F.
		EndIf
	
	Case ( c_TpoInc == '5' .AND. SIBMUC  == 2)//Mudanca Contratual 
	
		If ( len(a_Reg) >= 13 )
			a_Reg[13] 	:= .F.//Desconsidera o registro 
			lEnvia 		:= .F.
		EndIf                 
	  				
EndCase
//  novo tratamento para seleção do que enviar ao sib ==> altamiro , 23/10/18              
//If mv_par10 == 9 .and. ContaPD5() // mexer aki 25/01/19     nRet:=iiF (TMPQtda->qtda > 0 , .T. ,.F.)   
If fContaPD5() // mexer aki 25/01/19     nRet:=iiF (TMPQtda->qtda > 0 , .T. ,.F.)  
   If c_TpoInc == '1' .AND.  lEnvia == .T.
        If !ValCCo('INCL', ' ' , a_Reg[1] )                   
            a_Reg[29] := .F. 
               lEnvia := .F. 
        EndIf        
   ElseIf c_TpoInc == '2' .AND.  lEnvia == .T.
        If !ValCCo('RETI', a_Reg[1], ' '  )                   
            a_Reg[33] := .F. 
               lEnvia := .F. 
        EndIf                 altamiro	
   ElseIf c_TpoInc == '3' .AND.  lEnvia == .T.
        If !ValCCo('CANC', a_Reg[1], ' ' )                   
            a_Reg[5] := .F. 
               lEnvia := .F. 
        EndIf                         
   ElseIf c_TpoInc == '4' .AND.  lEnvia == .T.
        If !ValCCo('REAT', a_Reg[1], ' ' )                   
            a_Reg[04] := .F. 
               lEnvia := .F. 
        EndIf                                 
   ElseIf c_TpoInc == '5' .AND.  lEnvia == .T.
        If !ValCCo('MUDC', a_Reg[1], ' ' )                   
            a_Reg[13] := .F. 
               lEnvia := .F. 
        EndIf 
   EndIf 
EndIf 

// ativar para consultar vetor de inclusoes , exclusoes , alterações                                    
/*
If c_TpoInc == '2' .AND. lEnvia == .T.
   If len(a_Reg) >= 33          
      If  a_Reg[33]  == .T.                        
          If !ValCCoc( a_Reg[1] )                   
              a_Reg[33] := .F. 
              lEnvia := .F.
          EndIf  
      EndIf                                            
   EndIf 
EndIf                            
// ativar para consultar vetor de inclusoes e exclusoes                     
If c_TpoInc == '3' .AND.  lEnvia == .T.
   If len(a_Reg) >= 05                                  
      If  a_Reg[5]  == .T.                               
          If !ValCCoE( a_Reg[1] )                   
             a_Reg[5] := .F. 
             lEnvia := .F.
          EndIf  
      EndIf      
   EndIf 
EndIf        

If c_TpoInc == '1' .AND.  lEnvia == .T.
   If len(a_Reg) >= 29                                  
      If  a_Reg[29]  == .T.                               
          If !ValCCoM( a_Reg[1] )                   
             a_Reg[29] := .F. 
             lEnvia := .F.
          EndIf  
      EndIf      
   EndIf 
EndIf 

  */          

//Leonardo Portella - 20/03/17 - Início - Controlar os registros enviados (devido as manutenções, ocorre alteração nos registros e novos registros 
//são enviados sem a devida validação. Com o controle feito na tabela ENVIAR_SIB e em conjunto com o validador SIB CABR171, somente os registros 
//selecionados inicialmente serão enviados, evitando assim que registros não validados sejam enviados para a ANS) 
/*
cCargaInicio := GetGlbValue("SIB_INICIO")

If empty(cCargaInicio) //Este trecho só será executado 1 vez. Após isso a variável global SIB_INICIO será povoada

	//Verifica se existe carga gerada para o mês/ano e seta a variável global.

	cAlEnviar := GetNextAlias()
	
	cQry := "SELECT 1" 																+ CRLF
	cQry += "FROM ENVIAR_SIB" 														+ CRLF
	cQry += "WHERE EMPRESA = '" + If(cEmpAnt == '01','CABERJ','INTEGRAL') + "'" 	+ CRLF 
	cQry += "	AND ANO_MES = '" + Left(DtoS(Date()),6) + "'" 						+ CRLF
	cQry += "	AND ROWNUM = 1" 													+ CRLF
	
	TcQuery cQry New Alias cAlEnviar
	
	If cAlEnviar->(EOF()) //Não achou nada: é a primeira carga e o CABR171 ainda não foi rodado para povoar a tabela ENVIAR_SIB para a empresa
		PutGlbValue("SIB_INICIO","S")
		lCargaInicio := .T.
	Else
	
		cMsg := "Deseja MANTER APENAS os REGISTROS SELECIONADOS ANTERIORMENTE?"	+ CRLF 
		cMsg += "(Caso escolha NÃO manter, então novas inclusões, bloqueios, reativações ou retificações poderão ser incluídos no XML...)"
		
		If !MsgYesNo(cMsg, AllTrim(SM0->M0_NOMECOM))
		
			cScript := "BEGIN" 																									+ CRLF
			cScript += "DELETE FROM ENVIAR_SIB WHERE EMPRESA = '" + If(cEmpAnt == '01','CABERJ','INTEGRAL') + "';" 				+ CRLF
			cScript += "END;" 																									+ CRLF
			
			If TcSqlExec(cScript) < 0
				LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
			EndIf
	
			PutGlbValue("SIB_INICIO","S")
			lCargaInicio := .T.
	
		Else
		
			PutGlbValue("SIB_INICIO","N")
			lCargaInicio := .F.
			
		EndIf
		
	EndIf
	
	cAlEnviar->(DbCloseArea())
	
Else
	cCargaInicio := GetGlbValue("SIB_INICIO")
EndIf
	
If ( cCargaInicio <> 'S' ) .and. lEnvia

	cAlEnviar := GetNextAlias()
	
	cQry := "SELECT 1" 																+ CRLF
	cQry += "FROM ENVIAR_SIB" 														+ CRLF
	cQry += "WHERE EMPRESA = '" + If(cEmpAnt == '01','CABERJ','INTEGRAL') + "'"  	+ CRLF 
	
	If !empty(c_CCO)
		cQry += "	AND SIB_CODCCO = '" + c_CCO + "'" 								+ CRLF
	EndIf
	
	If !empty(c_Matric)
		cQry += "	AND SIB_MATRIC = '" + c_Matric + "'" 							+ CRLF
	EndIf
	
	TcQuery cQry New Alias cAlEnviar
	
	lEnvia := !cAlEnviar->(EOF())
	
	cAlEnviar->(DbCloseArea())
	
EndIf
*/
//Leonardo Portella - 20/03/17 - Fim

RestArea(aArea782)

Return a_Reg

*******************************************************************************************************

Static Function cGetCpoSIB(c_CodCCO,c_CpoSIB)

Local aArSIB 	:= GetArea()
Local aAlSIB	:= GetNextAlias()
Local u_Cpo		:= ''
Local c_Cpo		:= ''
Local cQrySIB	:= ''

cQrySIB += "SELECT " + c_CpoSIB 								+ CRLF
cQrySIB += "FROM CONFSIB_" + If(cEmpAnt == '01','CAB','INT')	+ CRLF
cQrySIB += "WHERE SIB_CODCCO = '" + c_CodCCO + "'"				+ CRLF

TcQuery cQrySIB New Alias aAlSIB

If !aAlSIB->(EOF()) 
	u_Cpo 	:= 'aAlSIB->' + c_CpoSIB
	u_Cpo 	:= &u_Cpo
	c_Cpo	:= cValToChar(u_Cpo)
EndIf

aAlSIB->(DbCloseArea())

RestArea(aArSIB)

Return c_Cpo

*********************************************************************************************************    

//Leonardo Portella - 14/09/15 - Validacao da critica 1802 e 1803 do SIB

User Function lTitularOk(cMat, cMatTitArq, l__PE)

Local aArea 		:= GetArea()
Local c_AliasTit 	:= GetNextAlias()
Local c_QryTit		:= ''
Local lOk			:= .F.
Local lAchouANS 	:= .F.

Default l__PE 		:= .F. //Indica se esta sendo chamado pelo ponto de entrada

If empty(cMatTitArq)//Se estiver vazio, o próprio beneficiário deve ser o titular
	cMatTitArq := cMat
EndIf

c_QryTit := "SELECT *" 																	+ CRLF
c_QryTit += "FROM CONFSIB_" + If(cEmpAnt == '01','CAB','INT') + " SIB" 					+ CRLF
c_QryTit += "WHERE SIB_MATRIC = '" + cMatTitArq + "'"									+ CRLF

TcQuery c_QryTit New Alias c_AliasTit

//1 - Verifica se existe na ANS

If !c_AliasTit->(EOF())//Se existir na ANS tem que ser como titular

	lAchouANS := .T.
	
	/*
	SIB_GRAUPA:
	01 - beneficiário titular
	03 - cônjuge/companheiro
	04 - filho/filha
	06 - enteado/enteada
	08 - pai/mãe
	10 - agregado/outros
	*/

	//lOk := ( AllTrim(c_AliasTit->SIB_GRAUPA) == '1' )//Se trouxer como titular na ANS esta Ok
	
	If empty(c_AliasTit->SIB_CCO_TITULAR)//Se não tiver CCO do titular indica que o próprio é titular (ANS não permite dependente sem titular)
		lOk := .T.
	EndIf

EndIf
	
c_AliasTit->(DbCloseArea())

//2 - Verifica se está sendo enviado neste SIB (l__PE: .T. - verifica no vetor do PE; .F. - Verifica na tabela de conferência povoada pelo CABR171)
 
If !lOk .and. !lAchouANS 

	//Se a chamada for do PE, as tabelas ENVIOSIB_CAB e/ou ENVIOSIB_INT ainda não estão povoadas pois o XML está 
	//sendo construído.
	If l__PE 

		//Busca no vetor private de inclusões do PLSA782
		If ( aScan(aRegInc, {|x|x[1] == cMatTitArq}) > 0 ) 
			lOk := .T. //Está no vetor e será encaminhado no SIB
		EndIf
	
	Else
		
		c_AliasTit 	:= GetNextAlias()
		
		c_QryTit := "SELECT SIB_GRAUPA"																						+ CRLF 
		c_QryTit += "FROM " + If(cEmpAnt == '01',"SIGA.ENVIOSIB_CAB","SIGA.ENVIOSIB_INT") + " TIT"							+ CRLF
		c_QryTit += "WHERE TIT.SIB_OPERACAO = 'INCLUSAO'"																	+ CRLF
		c_QryTit += "	AND TIT.SIB_MATRIC = '" + cMatTitArq + "'"															+ CRLF 
		
		TcQuery c_QryTit New Alias c_AliasTit
		
		lOk := !c_AliasTit->(EOF()) .and. ( AllTrim(c_AliasTit->SIB_GRAUPA) == '1' )//Se trouxer como titular na ANS esta Ok
		
		c_AliasTit->(DbCloseArea())
		
	EndIf
	
EndIf

//3 - Verifica se existe na base como enviado, caso tenha sido um SIB Global e o retorno ainda não tenha chegado (validando com uma base de conferência da
//ANS desatualizada)

If !lOk .and. !lAchouANS

	c_AliasTit 	:= GetNextAlias()
		
	c_QryTit := "SELECT BA1_LOCSIB, BA1_ENVANS, BA1_TIPUSU, BA1_TIPREG"											+ CRLF 
	c_QryTit += "FROM " + RetSqlname('BA1') 																	+ CRLF 
	c_QryTit += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'"													+ CRLF 
	c_QryTit += "	AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '" + cMatTitArq + "'"		+ CRLF 
	c_QryTit += "	AND D_E_L_E_T_ = ' '"																		+ CRLF 
	
	TcQuery c_QryTit New Alias c_AliasTit
	
	If Day(Date()) > 5 //Prazo do SIB é dia 5 de cada mês
	  	//Estou enviando ou validando o SIB no final do mês. Isso indica que o último envio ocorreu com data do 
	  	//último dia do mês anterior. Ex: Do dia 06/11 a 30/11, o último envio foi em 31/10 (último dia do mês anterior)
		dDtSIBAO := LastDay(MonthSub(Date(),1))
	Else 
		//Estou enviando ou validando o SIB no início do mês. Isso indica que o último envio ocorreu com data do 
	  	//último dia de 2 meses atrás. Ex: Do dia 01/12 a 05/12, o último envio foi em 31/10 (último dia do mês 2 meses atrás)
		dDtSIBAO := LastDay(MonthSub(Date(),2))
	EndIf
	
	//Verifica se existe na base do Protheus como titular, marcado como enviado para a ANS no último SIB. Isso é necessário
	//pois fazemos SIBÃO e o retorno da ANS pode não ter chegado ainda. Só valido ser estiver como enviado inclusão.
	
	lOk := 	!c_AliasTit->(EOF()) 							.and. ;
	 		( AllTrim(c_AliasTit->BA1_TIPREG) == '00' )		.and. ;  
	 		( AllTrim(c_AliasTit->BA1_TIPUSU) == 'T' ) 		.and. ;  
	 		( c_AliasTit->BA1_LOCSIB == '3' )				.and. ; //Enviado inclusão (enviei mas ainda não veio o retorno da ANS)
	 		( StoD(c_AliasTit->BA1_ENVANS) == dDtSIBAO ) 		
	 		
	c_AliasTit->(DbCloseArea())

EndIf

RestArea(aArea)

Return lOk

*******************************************************************************************************************

//Leonardo Portella - 21/03/16 - Verifica se a matrícula pertence a contrato/subcontrato de art 30/31

Static Function lArt30_31(c_Mat)

Local aArArt 	:= GetArea()
Local lArt 		:= .F.
Local cQryArt	:= ''
Local cAlArt	:= ''

cAlArt 	:= GetNextAlias()

cQryArt := "SELECT BQC_YSTSCO" 																					+ CRLF
cQryArt += "FROM " + RetSqlName('BA1') + " BA1" 																+ CRLF
cQryArt += "INNER JOIN " + RetSqlName('BQC') + " BQC ON BQC_FILIAL = '" + xFilial('BA1') + "'"					+ CRLF
cQryArt += "	AND BQC_CODIGO = BA1_CODEMP" 																	+ CRLF 
cQryArt += "	AND BQC_NUMCON = BA1_NUMCON" 																	+ CRLF 
cQryArt += "	AND BQC_VERCON = BA1_VERCON" 																	+ CRLF 
cQryArt += "	AND BQC_SUBCON = BA1_SUBCON" 																	+ CRLF 
cQryArt += "	AND BQC_VERSUB = BA1_VERSUB" 																	+ CRLF 
cQryArt += "	AND BQC.D_E_L_E_T_ = ' '" 																		+ CRLF 
cQryArt += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 														+ CRLF
cQryArt += "	AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '" + c_Mat + "'" 				+ CRLF
cQryArt += "	AND BA1.D_E_L_E_T_ = ' '" 																		+ CRLF

TcQuery cQryArt New Alias cAlArt

lArt := ( !cAlArt->(EOF()) .and. ( cAlArt->BQC_YSTSCO $ '01|02|03' ) ) //01 - ART 30; 02 - ART 31; 03 - AMBOS

cAlArt->(DbCloseArea())

RestArea(aArArt)

Return lArt  

///////////////////////////////////////////////// valida cco para Sibao - qualidade cadastral 
Static Function ValCCoc( cCCo )
  
  local lRet := .F.
         
  If cEmpAnt == '01'
  	If (nAscan:=Ascan( adADcCOc , {|e| e[1] == cCCo })) != 0                                                                                                                    
 
        lRet:= .T.
    
    EndIf     
  
  Else
  	
  	If (nAscan:=Ascan( adADcCOi , {|e| e[1] == cCCo })) != 0                                                                                                                    
 
        lRet:= .T.
    
    EndIf
            
  EndIf 
 return (lRet)      
 
 Static Function ValCCoE( cCCo )
  
  local lRet := .F.
         
  If cEmpAnt == '01'
  	If (nAscan:=Ascan( adADcCOcE , {|e| e[1] == cCCo })) != 0                                                                                                                    
 
        lRet:= .T.
    
    EndIf     
  
  Else
  	
  	If (nAscan:=Ascan( adADcCOiE , {|e| e[1] == cCCo })) != 0                                                                                                                    
 
        lRet:= .T.
    
    EndIf
            
  EndIf 
 return (lRet)  
 
 ///////////////////////////////////////////////// valida matricola para Sibao 
Static Function ValCCoM( cMatric )
  
  local lRet := .F.
         
  If cEmpAnt == '01'
  	If (nAscan:=Ascan( adADcCOcM , {|e| e[1] == cMatric })) != 0                                                                                                                    
 
        lRet:= .T.
    
    EndIf     
  
  Else
  	
  	If (nAscan:=Ascan( adADcCOiM , {|e| e[1] == cMatric })) != 0                                                                                                                    
 
        lRet:= .T.
    
    EndIf
            
  EndIf 
 return (lRet)    

///////////
//  novo tratamento para seleção do que enviar ao sib ==> altamiro , 23/10/18              

Static Function ValCCo( cTpAcao , cCCo , cMatric )

local c_Script := ' '      
local IdTit    := ' '      
local lRet     := .F.

                                             
if trim(cCCo) == ''

//   IdTit    := cMatric+cComp+cTpSib + cTpAcao+ strzero((fValseq(cComp,cTpSib)+1),2)       
   IdTit    := cMatric+cComp+cTpSib + cTpAcao+ strzero(fValseq(cComp,cTpSib),2)     
//   IdTit    := cMatric+cComp+cTpSib + cTpAcao+ '01'          

Else    

//   IdTit    :=  cCCo+cComp+cTpSib + cTpAcao + strzero((fValseq(cComp,cTpSib)+1),2)   
   IdTit    :=  cCCo+cComp+cTpSib + cTpAcao + strzero(fValseq(cComp,cTpSib),2)   
//   IdTit    :=  cCCo+cComp+cTpSib + cTpAcao + '01'     

EndIf                     
  
   dbselectarea("PD5")                                
 
 if trim(cCCo) == ''
    dbsetorder(2)
 Else    
    dbsetorder(1)
 EndIf 

 If dbseek(xFilial("PD5")+TRIM(IdTit)) //.AND. !lFazImp                                           
                                                                                                 
    If PD5_ENVIA == .T.                                           

       If mv_par10 == 1         
                                         
          RecLock("PD5",.F.)                     
                                                         
          PD5_ENVIAD   := .T.   
          PD5_DTENV    := stod(substr(dtos(date()),1,8))        
          
          PD5->(Msunlock())  

          If cSibEnv == 0                            
             aAreasx6 := GetArea()
             DbSelectArea("SX6")
             DbSetOrder(1)
             If DbSeek('  '+"MV_SIBENV")
                RecLock("SX6",.F.)
                SX6->X6_CONTEUD :=  '1'
                MsUnLock()
             Endif  
             RestArea(aAreasx6)
          Endif   
       
       EndIf         
       
       lRet:= .T. 

    Else     
    
       If mv_par10 == 1
    
          RecLock("PD5",.F.)                     
                                                         
          PD5_ENVIAD   := .F.   
          PD5_DTENV    := stod(substr(dtos(date()),1,8))        

          PD5->(Msunlock())      
                    
       EndIf 
       
       lRet:= .F.
               
    EndIf
    
 Else  
    
   If mv_par10 == 1
 
      lRet:= .F.
      
   Else      
         
      lRet:= .T.
        
   EndIf     

 EndIf 
 
 
return (lRet) 


Static Function  fValseq(cComp,cTpSib)    

local cQrySeq    := ' '
local nRet       := 0

cQrySeq := "SELECT NVL(MAX(PD5_SEQUEN),'00') SEQ " 			+ CRLF
cQrySeq += "FROM " + RetSqlName('PD5') + " PD5" 		    + CRLF
cQrySeq += "WHERE PD5_FILIAL = '" + xFilial('PD5') + "'"	+ CRLF
cQrySeq += "  AND PD5_COMPTE = '"+cComp+"'"  				+ CRLF 
cQrySeq += "  AND PD5_TPENVI = '"+cTpSib+"'" 			    + CRLF 
cQrySeq += "  AND PD5_ENVIAD = 'T' " 				        + CRLF 
cQrySeq += "  AND PD5_ARQENV <> ' ' " 				        + CRLF 
cQrySeq += "  AND PD5.D_E_L_E_T_ = ' ' " 					+ CRLF 

If Select("TMPSeq") <> 0 
   ("TMPSeq")->(DbCloseArea())                                    
EndIf 

TcQuery cQrySeq New Alias "TMPSeq"

   nRet:= val(TMPSeq->seq)+1                                   

return (nRet)	     

                           
Static Function fContaPD5()

local cQryCPd5   := ' '
local lRet       := .F.

cQryCPd5 := "SELECT COUNT(*) QTDA   "            	             		 + CRLF
cQryCPd5 += "FROM " + RetSqlName('PD5') + " PD5" 		                 + CRLF
cQryCPd5 += "WHERE PD5_FILIAL = '" + xFilial('PD5') + "'"	             + CRLF
cQryCPd5 += "  AND PD5_COMPTE = '"+cComp+"'"  			              	 + CRLF 
cQryCPd5 += "  AND PD5_TPENVI = '"+cTpSib+"'"            			     + CRLF 
cQryCPd5 += "  AND PD5_SEQUEN = '"+strzero(fValseq(cComp,cTpSib),2)+"'"  + CRLF      
cQryCPd5 += "  AND PD5.D_E_L_E_T_ = ' ' " 					             + CRLF 

If Select("TMPQtda") <> 0 
         ("TMPQtda")->(DbCloseArea())                                    
EndIf 

TcQuery cQryCPd5 New Alias "TMPQtda"

lRet:=iiF (TMPQtda->qtda > 0 , .T. ,.F.)     

return (lRet)	     

Static Function fTratEnd(Tpacao)

//tratamento para tipo de endereço  residencial  

If Tpacao =='Ret' 
   
	 a_Reg[12] := "2"  // tipo de endereço residencias
     a_Reg[19] := "0"  // residente exterior 

EndIf
 
If Tpacao =='Inc' 
   
	 a_Reg[11] := "2"  // tipo de endereço residencias
     a_Reg[18] := "0"  // residente exterior 

EndIf 
Return()


///////////////////////////////////////////

Static Function CaregaVet()  
If cEmpAnt == '01' //caberj 28/01/20119 

//aAdd(adADcCOc,{'018809695488'})   

EndIf 

Return() 