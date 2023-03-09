#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#include "TBICONN.CH"
#include "topconn.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA348   ºAutor  ³Marcela           º Data ³  05/12/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Botão libera bloqueio para NR 412                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/



User Function CABA348()
	
	Local c_MotUsuTm 	:= Replace(GetMv("MV_XBQUSU"),"'",'')
	Local c_MotFamTm 	:= Replace(GetMv("MV_XBQFAM"),"'",'')
	
	Local c_MotUsuFn 	:= Replace(GetMv("MV_XBQFUSU"),"'",'')
	Local c_MotFamFn 	:= Replace(GetMv("MV_XBQFFAM"),"'",'')
	
	Local a_AreaBa1		:= GetArea("BA1")
	Local c_chave 		:= BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC )
	Local d_Data		:= BA1->BA1_DATBLO
	
	Local l_Ok			:= .F.
	
	If !MsgYesNo("Confirma liberação do bloqueio? ")
		
		Return
		
	Endif
	
	If ( BA1->BA1_TIPUSU == 'T' .AND. BA1->BA1_MOTBLO == c_MotFamTm ) .OR. ( BA1->BA1_TIPUSU <> 'T' .AND. BA1->BA1_MOTBLO == c_MotFamTm )
		
		dbSelectArea("BA3")
		dbSetOrder(1)
		If dbSeek( XFILIAL("BA3")+ c_chave )
			
			l_Ok := .T.
			
			If cEmpAnt == "01"
				
				RecLock("BA3",.F.)
				
				BA3_MOTBLO := c_MotFamFn // Muda para aguardando cobrança
				//------------------------------------------------------------
				//INICIO - Mateus Medeiros - Data: 22/11/2017 - 40594
				//------------------------------------------------------------
				// Grava o tipo de cobrança Boleto na matricula anterior
				// na BA3 - Chamado - ID: 40594
				//------------------------------------------------------------
				BA3->BA3_TIPPAG := '04'   // Muda para Boleto
				BA3->BA3_PORTAD := '237'  // atribui banco
				BA3->BA3_AGEDEP := '3369' // atribui banco
				BA3->BA3_CTACOR := iif(BA3->BA3_CODEMP=="0001",GetNewPar("MV_XCTAMAT",'8895'),GetNewPar("MV_XCTAAFI",'5380')) // atribui banco
				//------------------------------------------------------------
				//FIM - Mateus Medeiros - Data: 22/11/2017 - 40594
				//------------------------------------------------------------
				BA3->BA3_GRPCOB:= IIF(BA3->BA3_CODEMP == '0001', '0002', '0003')
				BA3->BA3_VENCTO:= 10
				
				BA3->(MsUnLock())
				
			EndIf
			
		EndIf
		
		dbSelectArea("BC3")
		dbSetOrder(1)
		If dbSeek( XFILIAL("BC3")+ c_chave + DTOS( d_Data ) + "0" )
			
			l_Ok := .T.
			
			c_MotAnt := BCA->BCA_MOTBLO
			
			RecLock("BC3",.F.)
			
			BC3_MOTBLO := c_MotFamFn // Muda para aguardando cobrança
			BC3_XUSRLI := UsrFullName( __cUserId )
			BC3_XLIBER := "Liberado em: " + dtoc( DATE() ) + " MOTIVO ANTERIOR: " + c_MotAnt + "."   // c_MotAnt := BCA->BCA_MOTBLO
			
			MsUnLock()
			
		EndIf
		
		dbSelectArea("BA1")
		dbSetOrder(1)
		If dbSeek( XFILIAL("BA1") + c_chave )
			
			While !BA1->( EOF() ) .AND. BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC ) == c_Chave
				
				If BA1->BA1_MOTBLO == c_MotFamTm .AND. BA1->BA1_DATBLO == d_Data
					
					l_Ok := .T.
					
					RecLock("BA1", .F.)
					
					BA1_MOTBLO := c_MotFamFn // Muda para aguardando cobrança
					
					MsUnLock()
					
					dbSelectArea("BCA")
					dbSetOrder(1)
					If dbSeek( xFilial("BCA") + c_Chave + BA1->BA1_TIPREG + DTOS(BA1->BA1_DATBLO) + "0"  ) //BCA_FILIAL+BCA_MATRIC+BCA_TIPREG+DTOS(BCA_DATA)+BCA_TIPO
						
						l_Ok := .T.
						
						c_MotAnt := BCA->BCA_MOTBLO
						
						RecLock("BCA", .F. )
						
						BCA_MOTBLO := c_MotFamFn // Muda para aguardando cobrança
						BCA_XUSRLI := UsrFullName( __cUserId )
						BCA_XLIBER := "Liberado em: " + dtoc( DATE() ) + " MOTIVO ANTERIOR: " + c_MotAnt + "."  //c_MotAnt := BCA->BCA_MOTBLO
						
						MsUnLock()
						
					EndIf
					
				EndIf
				
				
				
				BA1->( dbSkip() )
				
			EndDo
			
		EndIf
		
	Else
		
		dbSelectArea("BA3")
		dbSetOrder(1)
		If dbSeek( XFILIAL("BA3") + c_chave ) .AND. BA3->BA3_MOTBLO = '  '
			
			If BA1->BA1_MOTBLO == c_MotUsuTm
				
				l_Ok := .T.
				
				RecLock("BA1", .F.)
				
				BA1_MOTBLO := c_MotUsuFn // Muda para aguardando cobrança
				
				MsUnLock()
				
				dbSelectArea("BCA")
				dbSetOrder(1)
				If dbSeek( xFilial("BCA") + c_Chave + BA1->BA1_TIPREG + DTOS(BA1->BA1_DATBLO) + "0"  ) //BCA_FILIAL+BCA_MATRIC+BCA_TIPREG+DTOS(BCA_DATA)+BCA_TIPO
					
					l_Ok := .T.
					c_MotAnt := BCA->BCA_MOTBLO
					
					RecLock("BCA", .F. )
					
					BCA_MOTBLO := c_MotUsuFn // Muda para aguardando cobrança     .
					BCA_XUSRLI := UsrFullName( __cUserId )
					BCA_XLIBER := "Liberado em: " + dtoc( DATE() ) + " MOTIVO ANTERIOR: " + c_MotAnt + "."   // c_MotAnt := BCA->BCA_MOTBLO
					
					MsUnLock()
					
				EndIf
				
			EndIf
			
		EndIf
		
		
	EndIF
	
	If l_Ok
		
		Alert("Bloqueio Liberado")
		
	EndIf
	
	RestArea( a_AreaBa1 )
	
Return
