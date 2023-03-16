#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "PLSMCCR.CH"
#include "TOPCONN.CH"

//����������������������������������������������������������������������������
//� DEFINE.
//����������������������������������������������������������������������������
#DEFINE PLS_ADMINITRADOR '2'
//�����������������������������������������������������������������������������
//� STATIC
//����������������������������������������������������������������������������
STATIC oLinkWord := NIL
//-------------------------------------------------------------------
/*/{Protheus.doc} CABPADRC
Controle das classes

@author Alexander Santos

@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
CLASS CABPADRC FROM PLSCONTR

DATA o790C			  	AS OBJECT
DATA cOperad		  	AS STRING
DATA cOwner		  		AS STRING
DATA cOwnerAud		  	AS STRING
DATA cAlias		   	AS STRING
DATA lMDDemanda 	  	AS LOGIC
DATA lEditaProcesso		AS LOGIC
DATA lIntSaudInco	  	AS LOGIC
DATA lMDParticipativa  	AS LOGIC
DATA lMDNotacoes 	  	AS LOGIC
DATA lMDEncaminhamento 	AS LOGIC
DATA lMDAnaliseGui     	AS LOGIC
DATA lMDRespAuditor	   	AS LOGIC
DATA lLastReg		  	AS LOGIC
DATA lOwnerEsp		   	AS LOGIC

METHOD New(cAlias) Constructor   

METHOD VWInitVLD( oView )
METHOD VWActBDocPro(oView,oButton)
METHOD VWOkCloseScreenVLD(oView,lExiMsg)
METHOD VWOkButtonVLD(oModel,cAlias)
METHOD VWListProc( oView, oButton )
METHOD MDCommit( oModel,cAlias )
METHOD MDPosVLD( oModel,cAlias )
METHOD MDPreVLD( oModel,cAlias )
METHOD MDActVLD(oModel)
METHOD MDCancelVLD( oGEN,cAlias )
METHOD VldRegOwner()
METHOD Destroy()

EndClass     
//-------------------------------------------------------------------
/*/{Protheus.doc} New
Construtor da Class

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD New(cAlias) CLASS CABPADRC
DEFAULT ::lLastReg := .F.

::cAlias := cAlias
::o790C  := CABA790C():New() 
//����������������������������������������������������������������������������
//� Atualiza informacoes da classe
//����������������������������������������������������������������������������
AtuPClass(Self)
//����������������������������������������������������������������������������
//� Fim do metodo
//����������������������������������������������������������������������������
Return Self                  
//-------------------------------------------------------------------
/*/ { Protheus.doc } MDPreVLD
Pre validacao do modelo de dados.

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD MDPreVLD(oModel,cAlias) CLASS CABPADRC
LOCAL lRet := .T.
//����������������������������������������������������������������������������
//� Fim da Rotina															 
//����������������������������������������������������������������������������
Return(lRet)                
//-------------------------------------------------------------------
/*/ { Protheus.doc } MDPosVLD
Pos validacao do modelo de dados.

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD MDPosVLD( oModel,cAlias, cModelDet,lFluig ) CLASS CABPADRC
LOCAL aArea      	:= GetArea()
LOCAL lRet		 	:= .T.
LOCAL cChave	 	:= ""
LOCAL nOperation 	:= oModel:GetOperation()
LOCAL oModelD 	 	:= oModel:GetModel( oModel:GetModelIds()[1] )
LOCAL oGEN		 	:= NIL
LOCAL aSaveLines 	:= {}
DEFAULT lFluig   := .F. 

If lFluig
	If !Empty(cModelDet) // passa o nome do model usado na estrutura de detalhes (FLUIG)
		oModelD 	 := oModel:GetModel( cModelDet )
	ELse
		oModelD 	 := oModel:GetModel( oModel:GetModelIds()[1] )
	EndIF
EndIf

//����������������������������������������������������������������������������
//� Registro nao existe
//����������������������������������������������������������������������������
If lRet
	//����������������������������������������������������������������������������
	//� Somente Inclusao
	//����������������������������������������������������������������������������
	If nOperation == MODEL_OPERATION_INSERT .OR. (nOperation == MODEL_OPERATION_UPDATE ) .AND. lFluig
		//����������������������������������������������������������������������������
		//� Chave de Ligacao
		//����������������������������������������������������������������������������
		oModelD:SetValue( cAlias+'_FILIAL', xFilial("B53") )
		oModelD:SetValue( cAlias+'_ALIMOV', B53->B53_ALIMOV )
		oModelD:SetValue( cAlias+'_RECMOV', B53->B53_RECMOV )
		//����������������������������������������������������������������������������
		//� Registrando complementar
		//����������������������������������������������������������������������������
		oModelD:SetValue( cAlias+'_OPERAD', RETCODUSR() )         
		
		//����������������������������������������������������������������������������
		//� Analise da guia
		//����������������������������������������������������������������������������
		If ::lMDAnaliseGui .And. !::o790C:lIntSau 
			//����������������������������������������������������������������������������
			//� Registrando complementar
			//����������������������������������������������������������������������������
			//IF (!::o790C:lRotinaGen)
				oModelD:SetValue( 'B72_SEQPRO', _Super:RetConCP(::o790C:cAIte,"SEQUEN") )
				oModelD:SetValue( 'B72_CODPAD', _Super:RetConCP(::o790C:cAIte,"CODPAD") )
				oModelD:SetValue( 'B72_CODPRO', _Super:RetConCP(::o790C:cAIte,"CODPRO") )
				oModelD:SetValue( 'B72_CODGLO', _Super:RetConCP(::o790C:cACri,"CODGLO") )
			/*ELSE
				oModelD:SetValue( 'B72_SEQPRO', "000" )
				oModelD:SetValue( 'B72_CODPAD', "00" )
				oModelD:SetValue( 'B72_CODGLO', "000" )
				oModelD:SetValue( 'B72_CODPRO', ::o790C:cAIte + cValtoChar((::o790C:cAIte)->(RECNO())) )		
			ENDIF*/	
		EndIf	                              
		//����������������������������������������������������������������������������
		//� Resposta auditor
		//����������������������������������������������������������������������������
		If ::lMDRespAuditor
			oModelD:SetValue( 'B73_SEQPRO', B72->B72_SEQPRO )
			oModelD:SetValue( 'B73_CODGLO', B72->B72_CODGLO )
		EndIf
		//����������������������������������������������������������������������������
		//� Demanda
		//����������������������������������������������������������������������������
		If ::lMDDemanda
			cChave := oModelD:GetValue("B68_ALIMOV")+oModelD:GetValue("B68_RECMOV")+oModelD:GetValue("B68_NUMPRC")+oModelD:GetValue("B68_TPPROC")
		//����������������������������������������������������������������������������
		//� Notacoes,Participativa e Encaminhamentos
		//����������������������������������������������������������������������������
		ElseIf ::lMDNotacoes .Or. ::lMDParticipativa .Or. ::lMDEncaminhamento
			cChave := oModelD:GetValue(cAlias+"_ALIMOV")+oModelD:GetValue(cAlias+"_RECMOV")+oModelD:GetValue(cAlias+"_SEQUEN")
		//����������������������������������������������������������������������������
		//� Analise e interna-saude
		//����������������������������������������������������������������������������
		ElseIf ::lMDAnaliseGui 
			cChave := oModelD:GetValue("B72_ALIMOV")+oModelD:GetValue("B72_RECMOV")+oModelD:GetValue("B72_SEQPRO")+oModelD:GetValue("B72_CODGLO")
		ELSEIF ::lMDAnaliseGui 
			cChave := oModelD:GetValue("B72_ALIMOV")+oModelD:GetValue("B72_RECMOV")+oModelD:GetValue("B72_SEQPRO")+oModelD:GetValue("B72_CODGLO")+oModelD:GetValue("B72_CODPAD")+AllTrim(oModelD:GetValue("B72_CODPRO"))//Armazeno no codpro alias e rec de item
		ElseIf ::lMDRespAuditor
			cChave := oModelD:GetValue("B73_ALIMOV")+oModelD:GetValue("B73_RECMOV")+oModelD:GetValue("B73_SEQPRO")+oModelD:GetValue("B73_CODGLO")+oModelD:GetValue("B73_SEQUEN")
		EndIf
		//����������������������������������������������������������������������������
		//� Salvo a linha corrente													 
		//����������������������������������������������������������������������������
		aSaveLines := FWSaveRows()
		//����������������������������������������������������������������������������
		//� Verifico a existencia da chave
		//����������������������������������������������������������������������������
		oGEN := CABREGIC():New()
		oGEN:GetDadReg(cAlias,1, xFilial(cAlias) + cChave ,,,.F. )
	
		If oGEN:lFound .AND. nOperation != MODEL_OPERATION_UPDATE
			_Super:ExbMHelp( "J� existe este registro na base de dados" ) //"J� existe este registro na base de dados"
			lRet := .F.
		EndIf         
		
		oGEN:Destroy()
		//����������������������������������������������������������������������������
		//� Restaura a opcao da linha do grid (modelo)								 
		//����������������������������������������������������������������������������
		FWRestRows( aSaveLines )       
	EndIf	
EndIf
//����������������������������������������������������������������������������
//� Rest nas linhas do browse e na area										 
//����������������������������������������������������������������������������
RestArea( aArea )                   
//����������������������������������������������������������������������������
//� Fim da Rotina															 
//����������������������������������������������������������������������������
Return(lRet)                
//-------------------------------------------------------------------
/*/ { Protheus.doc } MDCommit
Faz o commit necessario do modelo

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD MDCommit( oModel,cAlias , cModelDet, lFluig) Class CABPADRC
LOCAL aArea      	:= GetArea()
LOCAL oB53		 	:= NIL
LOCAL oGEN 		:= NIL
LOCAL oB72		 	:= NIL
LOCAL oGCRI		:= NIL
LOCAL oGITE		:= NIL
LOCAL oBEA			:= NIL
LOCAL oBE4			:= NIL
LOCAL oRegGui	:= NIL
LOCAL cACab		:= ""
LOCAL cAIte		:= ""
LOCAL cACri		:= ""
LOCAL cGuiaSadt	:= ""
LOCAL cParecer 	:= ""
LOCAL cGuiaInter	:= ""
LOCAL cChave 	 	:= ""
LOCAL cCodGlo 	 	:= ""
LOCAL cPerfil	 	:= ""
LOCAL aChave	 	:= {}
LOCAL aAutFor	 	:= {}
LOCAL aMatGlo		:= {}
LOCAL lAutorizado	:= .F.
LOCAL lNegado 	 	:= .F.
LOCAL lAtuCri	 	:= .F.
LOCAL lAtuHis	 	:= .T.
LOCAL lLastReg	 	:= .F.
LOCAL nOperation 	:= oModel:GetOperation()
LOCAL nOpc		 	:= 0
LOCAL nI			:= 1
LOCAL oModelD 	 	:= oModel:GetModel( oModel:GetModelIds()[1] )
LOCAL lGuiAudit   := .T.
LOCAL oBR8
LOCAL oBE2
LOCAL aChaveBQV := {}
Local aTmp			:= {}
Local cTmp			:= ""
Local nSom			:= 0
DEFAULT lFluig := .F.

If lFluig
	If !Empty(cModelDet) // passa o nome do model usado na estrutura de detalhes (FLUIG)
		oModelD 	 := oModel:GetModel( cModelDet )
	ELse
		oModelD 	 := oModel:GetModel( oModel:GetModelIds()[1] )
	EndIF
EndIf

//����������������������������������������������������������������������������
//� Se for alteracao ou inclusao
//����������������������������������������������������������������������������
If nOperation == MODEL_OPERATION_INSERT .Or. nOperation == MODEL_OPERATION_UPDATE  .AND. lFluig   
	//����������������������������������������������������������������������������
	//� Atualizacao referente ao cabecalho
	//����������������������������������������������������������������������������
	Do Case 
		//����������������������������������������������������������������������������
		//� Participativa
		//����������������������������������������������������������������������������
		Case ::lMDParticipativa
			 
			dbSelectArea("BE2")
			dbSetOrder(1)
			
			If dbSeek(xFilial("BE2")+B53->B53_NUMGUI)
				
				While BE2->(BE2_FILIAL + BE2_OPEMOV + BE2_ANOAUT + BE2_MESAUT + BE2_NUMAUT) ==  xFilial("BE2")+B53->B53_NUMGUI
						::lMDAnaliseGui := .T.
						::o790C:lIntSau := .F.
					
					If BE2->BE2_AUDITO == "1" 
						lGuiAudit := .F.
						EXIT
					EndIf
										
					BE2->(dbSkip())
				EndDo
			EndIf

		//����������������������������������������������������������������������������
		//� Encaminhamentos
		//����������������������������������������������������������������������������
		Case ::lMDEncaminhamento
			//����������������������������������������������������������������������������
			//� Monta Chave
			//����������������������������������������������������������������������������
			aChave := {}             
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_OPEMOV"), '=', Left(B53->B53_NUMGUI,4) 		} )
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_ANOAUT"), '=', SubStr(B53->B53_NUMGUI,5,4) 	} )
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_MESAUT"), '=', SubStr(B53->B53_NUMGUI,9,2) 	} )
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_NUMAUT"), '=', Right(B53->B53_NUMGUI,8) 		} )
			If (::o790C:cACri)->( FieldPos(::o790C:cACri+"_PENDEN") ) > 0  
				AaDd(aChave, { ::o790C:cACri + "_PENDEN", 'IN', "('')" } )
			Endif
			//����������������������������������������������������������������������������
			//� Verifica se ainda tem procedimento a ser analisado
			//����������������������������������������������������������������������������
			aChaveBQV := {}
			
			AaDd(aChaveBQV, { ::o790C:SetFieldGui("BQV_CODOPE"), '=', Left(B53->B53_NUMGUI,4) 		} )
			AaDd(aChaveBQV, { ::o790C:SetFieldGui("BQV_ANOINT"), '=', SubStr(B53->B53_NUMGUI,5,4) 	} )
			AaDd(aChaveBQV, { ::o790C:SetFieldGui("BQV_MESINT"), '=', SubStr(B53->B53_NUMGUI,9,2) 	} )
			AaDd(aChaveBQV, { ::o790C:SetFieldGui("BQV_NUMINT"), '=', Right(B53->B53_NUMGUI,8) 		} )
			AaDd(aChaveBQV, { ::o790C:SetFieldGui("BQV_AUDITO"), '=', "1" 		} )
			//����������������������������������������������������������������������������
			//� Verifica se ainda tem procedimento a ser analisado
			//����������������������������������������������������������������������������
			oGEN 	 := CABREGIC():New()
			If oGEN:GetCountReg("BQV",aChaveBQV) == 0
		
				lLastReg := oGEN:GetCountReg(::o790C:cACri,aChave ) == 0       
	 		Else
	 			
	 			lLastReg := .F.
	 			
			EndIf
 			
			oGEN:Destroy()
			//����������������������������������������������������������������������������
			//� Atualiza o cabecalho
			//����������������������������������������������������������������������������
			oB53 := PLSSTRUC():New("B53",MODEL_OPERATION_UPDATE,,B53->( Recno() ))  
			oB53:SetValue("B53_OPEENC",B53->B53_OPERAD )
			oB53:SetValue("B53_CODDEP",oModelD:GetValue("B71_CODDEP") )
			oB53:SetValue("B53_ENCAMI","1")
			//����������������������������������������������������������������������������
			//� Verifica se pode retirar o operador e coloca como analisada nao
			//����������������������������������������������������������������������������
			If !lLastReg
				oB53:SetValue("B53_OPERAD","")
				oB53:SetValue("B53_SITUAC","0" ) 
			EndIf
			oB53:CRUD() 
		//����������������������������������������������������������������������������
		//� Analise
		//����������������������������������������������������������������������������
		Case ::lMDAnaliseGui .And. !::o790C:lIntSau   
			//����������������������������������������������������������������������������
			//� Alias
			//����������������������������������������������������������������������������
			cACab := Iif(::o790C:lInternacao,"BEA",::o790C:cACab)
			//����������������������������������������������������������������������������
			//� Posiciona no tabela com base no numero da guia
			//����������������������������������������������������������������������������
			(cACab)->( DbGoTo(Val(B53->B53_RECMOV)) ) //r7
			//�����������������������������������������������������������������������������
			//� Se for autorizado guarda o historico de autorizacao
			//�����������������������������������������������������������������������������
			If oModelD:GetValue( 'B72_PARECE' ) $ '0,1'                  
				//������������������������������������������������������������������������������������������������������������
				//� Historico
				//������������������������������������������������������������������������������������������������������������
		        AaDd( aAutFor, {.T., oModelD:GetValue('B72_CODPAD'), oModelD:GetValue('B72_CODPRO'),;
		        				  "","","","",0,RETCODUSR(),Date(),Time(), oModelD:GetValue('B72_MOTIVO'),;
		        				  "",oModelD:GetValue('B72_SEQPRO') } )
				//������������������������������������������������������������������������������������������������������������
				//� Se a opcao todos nao foi selecionada
				//������������������������������������������������������������������������������������������������������������
				
					oGITE := PLSSTRUC():New(::o790C:cAIte,MODEL_OPERATION_UPDATE,,(::o790C:cAIte)->( Recno() ) )
					oGITE:SetValue( ::o790C:cAIte+"_VLRAPR", oModelD:GetValue( 'B72_VLRAUT' ) )                                         
						
					If ::o790C:cAIte+"_QTDPRO" != "BE2"
						oGITE:SetValue( ::o790C:cAIte+"_QTDPRO", oModelD:GetValue( 'B72_QTDAUT' ) )
						oGITE:SetValue( ::o790C:cAIte+"_SALDO", (oModelD:GetValue( 'B72_QTDSOL') -  oModelD:GetValue( 'B72_QTDAUT')) )
					EndIf
					
					oGITE:SetValue( ::o790C:cAIte+"_VIA", oModelD:GetValue( 'B72_VIA' ) )
					oGITE:SetValue( ::o790C:cAIte+"_PERVIA", oModelD:GetValue( 'B72_PERVIA' ) )
					oGITE:CRUD()
					
					oGITE:Destroy()
				
			EndIf
			//����������������������������������������������������������������������������������������������������
			//� Alimenta a tabela de critica com o operador da analise todas as glosas do perfil ou a selecionada
			//����������������������������������������������������������������������������������������������������
			cChave := B53->B53_FILIAL + B53->B53_NUMGUI + oModelD:GetValue( 'B72_SEQPRO' )
			
			//Posiciona na glosa
			(::o790C:cACri)->(dbSetOrder(1))
			If (::o790C:cACri)->(MsSeek(cChave))
				//Indica que deve atualizar o historico de criticas por se tratar da primeira glosa
				lAtuHis := .T.
				
				If !lFluig //.AND. !::o790C:lRotinaGen			
					While !(::o790C:cACri)->( Eof() ) .And. cChave == xFilial(::o790C:cACri)+(::o790C:cACri)->&( ::o790C:SetFieldGui(::o790C:cACri+"_OPEMOV+"+::o790C:cACri+"_ANOAUT+"+::o790C:cACri+"_MESAUT+"+::o790C:cACri+"_NUMAUT+"+::o790C:cACri+"_SEQUEN") )
		 				
		                cCodGlo := (::o790C:cACri)->&( ::o790C:cACri+"_CODGLO" )
						//����������������������������������������������������������������������������
						//� Somente glosas nao analisadas ainda
						//����������������������������������������������������������������������������
						If Empty( (::o790C:cACri)->&( ::o790C:cACri+"_OPERAD" ) ) .Or. ::o790C:cOwner == (::o790C:cACri)->&( ::o790C:cACri+"_OPERAD" )
							//����������������������������������������������������������������������������
							//� Se foi autorizado exclui a glosa
							//����������������������������������������������������������������������������
							If oModelD:GetValue( 'B72_PARECE' ) == '0'
								nOpc := MODEL_OPERATION_DELETE
							Else
								nOpc := MODEL_OPERATION_UPDATE
							EndIf	
							//����������������������������������������������������������������������������
							//� Somente a glosa principal
							//����������������������������������������������������������������������������
							If !Empty(cCodGlo)
								//����������������������������������������������������������������������������
								//� Guarda codigo das glosas para criacao da B72
								//����������������������������������������������������������������������������
								AaDd(aMatGlo, cCodGlo )
								//����������������������������������������������������������������������������
								//� Posiciona na glosa
								//����������������������������������������������������������������������������
								If (::o790C:cACri)->( FieldPos(::o790C:cACri + "_TIPO") ) > 0 .And. !Empty( (::o790C:cACri)->&( ::o790C:cACri + "_TIPO" ) )
									cPerfil := (::o790C:cACri)->&( ::o790C:cACri + "_TIPO" )
								Else	
									oGEN := CABREGIC():New()
									oGEN:GetDadReg( "BCT",1, xFilial("BCT") + B53->B53_CODOPE + cCodGlo )    
									cPerfil := oGEN:GetValue("BCT_TIPO")
									oGEN:Destroy()
								EndIf
						  	    lAtuCri := .F.
								//����������������������������������������������������������������������������
								//� Verifica se a glosa esta relacionada ao perfil do operador
								//����������������������������������������������������������������������������
							  	If ::o790C:cPerfil == PLS_ADMINITRADOR .Or. ::o790C:cPerfil == cPerfil
									//����������������������������������������������������������������������������
									//� Atualiza critica
									//����������������������������������������������������������������������������
							  	    lAtuCri := .T.
									//����������������������������������������������������������������������������
									//� Atualiza o operador e se a critica ainda esta pendente
									//����������������������������������������������������������������������������
									oGCRI 	:= PLSSTRUC():New(::o790C:cACri,nOpc,,(::o790C:cACri)->( Recno() ) )
									oGCRI:SetValue( ::o790C:cACri+"_OPERAD",::o790C:cOwner )                                       
									//����������������������������������������������������������������������������
									//� 0=Autorizado;1=Negado;2=Em Analise
									//����������������������������������������������������������������������������
									oGCRI:SetValue( ::o790C:cACri+"_PENDEN", Iif( oModelD:GetValue( 'B72_PARECE' ) == '2','1','0') )
									oGCRI:CRUD()                                                                      
									//������������������������������������������������������������������������������������������������������������
									//� Grava Historico
									//������������������������������������������������������������������������������������������������������������
									If oModelD:GetValue( 'B72_PARECE' ) $ '0,1' .And. lAtuHis
										
										If ::o790C:cACab == "BE4" 
										
											(::o790C:cACab)->(dbSetOrder(2))
											(::o790C:cACab)->(MsSeek(&( ::o790C:cACab+"->"+::o790C:cACab+"_FILIAL" )+B53->B53_NUMGUI))
										Else
											(::o790C:cACab)->(dbSetOrder(1))
											(::o790C:cACab)->(MsSeek(&( ::o790C:cACab+"->"+::o790C:cACab+"_FILIAL" )+B53->B53_NUMGUI))
										EndIf 
										
										PLSFORHIS(MODEL_OPERATION_INSERT,Iif(AllTrim(B53->B53_TIPO)$"1,2","1",B53->B53_TIPO),cACab,aAutFor, {{ { cCodGlo,"", oModelD:GetValue('B72_CODPAD') + "-" + AllTrim(oModelD:GetValue('B72_CODPRO')) } }} )
										//Indica que NAO deve mais atualizar o historico de criticas
										lAtuHis := .F.
									EndIf	
								EndIf
							//����������������������������������������������������������������������������
							//� Atualiza o complemento da critica
							//����������������������������������������������������������������������������
							ElseIf lAtuCri
								//����������������������������������������������������������������������������
								//� Atualiza o operador e se a critica ainda esta pendente
								//����������������������������������������������������������������������������
								oGCRI := PLSSTRUC():New(::o790C:cACri,nOpc,,(::o790C:cACri)->( Recno() ) )
								oGCRI:SetValue( ::o790C:cACri+"_OPERAD",::o790C:cOwner )                                       
								//����������������������������������������������������������������������������
								//� 0=Autorizado;1=Negado;2=Em Analise
								//����������������������������������������������������������������������������
								oGCRI:SetValue( ::o790C:cACri+"_PENDEN", Iif( oModelD:GetValue( 'B72_PARECE' ) == '2','1','0') )
								oGCRI:CRUD()                                                                      
			                EndIf
			            EndIf        
					(::o790C:cACri)->( DbSkip() )				
					EndDo
				/*ElseIF !::o790C:lRotinaGen  //r7 
					While !(::o790C:cACri)->( Eof() ) .And. cChave ==BEG->(BEG_FILIAL + BEG_OPEMOV + BEG_ANOAUT + BEG_MESAUT + BEG_NUMAUT + BEG_SEQUEN) 
						
		                cCodGlo := (::o790C:cACri)->&( ::o790C:cACri+"_CODGLO" )
						//����������������������������������������������������������������������������
						//� Somente glosas nao analisadas ainda
						//����������������������������������������������������������������������������
						If Empty( (::o790C:cACri)->&( ::o790C:cACri+"_OPERAD" ) ) .Or. ::o790C:cOwner == (::o790C:cACri)->&( ::o790C:cACri+"_OPERAD" )
							//����������������������������������������������������������������������������
							//� Se foi autorizado exclui a glosa
							//����������������������������������������������������������������������������
							If oModelD:GetValue( 'B72_PARECE' ) == '0'
								nOpc := MODEL_OPERATION_DELETE                              
							Else
								nOpc := MODEL_OPERATION_UPDATE                              
							EndIf	
							//����������������������������������������������������������������������������
							//� Somente a glosa principal
							//����������������������������������������������������������������������������
							If !Empty(cCodGlo)
								//����������������������������������������������������������������������������
								//� Guarda codigo das glosas para criacao da B72
								//����������������������������������������������������������������������������
								AaDd(aMatGlo, cCodGlo )
								//����������������������������������������������������������������������������
								//� Posiciona na glosa
								//����������������������������������������������������������������������������
								If (::o790C:cACri)->( FieldPos(::o790C:cACri + "_TIPO") ) > 0 .And. !Empty( (::o790C:cACri)->&( ::o790C:cACri + "_TIPO" ) )
									cPerfil := (::o790C:cACri)->&( ::o790C:cACri + "_TIPO" )
								Else	
									oGEN := CABREGIC():New()
									oGEN:GetDadReg( "BCT",1, xFilial("BCT") + B53->B53_CODOPE + cCodGlo )    
									cPerfil := oGEN:GetValue("BCT_TIPO")
									oGEN:Destroy()
								EndIf
						  	    lAtuCri := .F.
								//����������������������������������������������������������������������������
								//� Verifica se a glosa esta relacionada ao perfil do operador
								//����������������������������������������������������������������������������
							  	If ::o790C:cPerfil == PLS_ADMINITRADOR .Or. ::o790C:cPerfil == cPerfil
									//����������������������������������������������������������������������������
									//� Atualiza critica
									//����������������������������������������������������������������������������
							  	    lAtuCri := .T.
									//����������������������������������������������������������������������������
									//� Atualiza o operador e se a critica ainda esta pendente
									//����������������������������������������������������������������������������
									oGCRI 	:= PLSSTRUC():New(::o790C:cACri,nOpc,,(::o790C:cACri)->( Recno() ) )
									oGCRI:SetValue( ::o790C:cACri+"_OPERAD",::o790C:cOwner )                                       
									//����������������������������������������������������������������������������
									//� 0=Autorizado;1=Negado;2=Em Analise
									//����������������������������������������������������������������������������
									oGCRI:SetValue( ::o790C:cACri+"_PENDEN", Iif( oModelD:GetValue( 'B72_PARECE' ) == '2','1','0') )
									oGCRI:CRUD()                                                                      
									//������������������������������������������������������������������������������������������������������������
									//� Grava Historico
									//������������������������������������������������������������������������������������������������������������
									If oModelD:GetValue( 'B72_PARECE' ) $ '0,1' .And. lAtuHis
										PLSFORHIS(MODEL_OPERATION_INSERT,Iif(AllTrim(B53->B53_TIPO)$"1,2","1",B53->B53_TIPO),cACab,aAutFor, {{ { cCodGlo,"", oModelD:GetValue('B72_CODPAD') + "-" + AllTrim(oModelD:GetValue('B72_CODPRO')) } }} )
										//Indica que NAO deve mais atualizar o historico de criticas
										lAtuHis := .F.
									EndIf	
			                    EndIf
							//����������������������������������������������������������������������������
							//� Atualiza o complemento da critica
							//����������������������������������������������������������������������������
							ElseIf lAtuCri
								//����������������������������������������������������������������������������
								//� Atualiza o operador e se a critica ainda esta pendente
								//����������������������������������������������������������������������������
								oGCRI := PLSSTRUC():New(::o790C:cACri,nOpc,,(::o790C:cACri)->( Recno() ) )
								oGCRI:SetValue( ::o790C:cACri+"_OPERAD",::o790C:cOwner )                                       
								//����������������������������������������������������������������������������
								//� 0=Autorizado;1=Negado;2=Em Analise
								//����������������������������������������������������������������������������
								oGCRI:SetValue( ::o790C:cACri+"_PENDEN", Iif( oModelD:GetValue( 'B72_PARECE' ) == '2','1','0') )
								oGCRI:CRUD()                                                                      
			                EndIf
			            EndIf        
					(::o790C:cACri)->( DbSkip() )				
					EndDo*/
				EndIf 
			EndIf
			//������������������������������������������������������������������������������������������������������������
			//� Parecer informado pelo usuario
			//������������������������������������������������������������������������������������������������������������
			cParecer := oModelD:GetValue( 'B72_PARECE' )						
			//������������������������������������������������������������������������������������������������������������
			//� Verifica se existe alguma pendencia
			//������������������������������������������������������������������������������������������������������������
			aChave := {}
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_OPEMOV"), '=', Left(B53->B53_NUMGUI,4) } )
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_ANOAUT"), '=', SubStr(B53->B53_NUMGUI,5,4) } )
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_MESAUT"), '=', SubStr(B53->B53_NUMGUI,9,2) } )
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_NUMAUT"), '=', Right(B53->B53_NUMGUI,8) } )
			AadD(aChave, { ::o790C:cACri + "_SEQUEN", '=', oModelD:GetValue( 'B72_SEQPRO' ) } )		
			AadD(aChave, { ::o790C:cACri + "_PENDEN", '<>', '0' } )		
			//����������������������������������������������������������������������������
			//� Se tem pendencia
			//����������������������������������������������������������������������������
			oGEN 	 	:= CABREGIC():New()
			lNEstPen 	:= oModelD:GetValue( 'B72_PARECE' ) $ '0,1' //oGEN:GetCountReg(::o790C:cACri,aChave ) == 0
			oGEN:Destroy()
			//����������������������������������������������������������������������������
			//� Se nao esta pendente, mas tem critica na base o procedimento foi negado
			//����������������������������������������������������������������������������
			If lNEstPen //.AND. !::o790C:lRotinaGen
				aChave := {}
				AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_OPEMOV"), '=', Left(B53->B53_NUMGUI,4) } )
				AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_ANOAUT"), '=', SubStr(B53->B53_NUMGUI,5,4) } )
				AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_MESAUT"), '=', SubStr(B53->B53_NUMGUI,9,2) } )
				AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cACri + "_NUMAUT"), '=', Right(B53->B53_NUMGUI,8) } )
				AaDd(aChave, { ::o790C:cACri + "_SEQUEN", '=', oModelD:GetValue( 'B72_SEQPRO' ) } )
				AaDd(aChave, { ::o790C:cACri + "_PENDEN", '=', '0'  } )
				//����������������������������������������������������������������������������
				//� Verifica se existe critica negada
				//����������������������������������������������������������������������������
				oGEN := CABREGIC():New()
				If oGEN:GetCountReg(::o790C:cACri,aChave ) > 0
					cParecer := "1"
				EndIf     
				oGEN:Destroy()
				//����������������������������������������������������������������������������
				//� Ajuste dos alias para chamada da funcao na antiga auditoria
				//����������������������������������������������������������������������������
				cACab 		:= ::o790C:cACab
				cAIte 		:= ::o790C:cAIte
				cACri 		:= ::o790C:cACri
				cGuiaSadt	:= ::o790C:cNumGuia
				cGuiaInter	:= ""
				//����������������������������������������������������������������������������
				//� Na internacao
				//����������������������������������������������������������������������������
				If ::o790C:lInternacao .And. !::o790C:lEvolucao
					//����������������������������������������������������������������������������
					//� Alias
					//����������������������������������������������������������������������������
					cACab 		:= "BEA"
					cAIte 		:= "BE2"
					cACri 		:= "BEG"
					cGuiaInter := ::o790C:cNumGuia
					//����������������������������������������������������������������������������
					//� Posiciona no bea com base no numero da guia
					//����������������������������������������������������������������������������
					oGEN := CABREGIC():New()
					oGEN:GetDadReg(cACab,6, xFilial(cACab)+B53->B53_NUMGUI )
					
					If oGEN:lFound
						cGuiaSadt := oGEN:GetValue("BEA_OPEMOV")+oGEN:GetValue("BEA_ANOAUT")+oGEN:GetValue("BEA_MESAUT")+oGEN:GetValue("BEA_NUMAUT")
						//����������������������������������������������������������������������������
						//� Posiciona no be2 e beg com base no bea
						//����������������������������������������������������������������������������
						oGEN:GetDadReg(cAIte,1, xFilial(cAIte)+cGuiaSadt,,,.F. )
						oGEN:GetDadReg(cACri,1, xFilial(cACri)+cGuiaSadt,,,.F. )
					Else
						QOut("Integridade, N�o foi poss�vel encontrar o BEA com base no BE4 chave [" + B53->B53_NUMGUI + "]")	 //"Integridade, N�o foi poss�vel encontrar o BEA com base no BE4 chave ["
					EndIf   
					oGEN:Destroy()
				EndIf
				//����������������������������������������������������������������������������
				//� Grava e realiza ajustes relacionados ITEM,CRITICA E CONTAS
				//����������������������������������������������������������������������������
				//IF (!::o790C:lRotinaGen)
				PLS790GVA(	cACab,;
							cAIte,;
							cACri,;
							.T.,;
							.T.,;
							.F.,;              
							::o790C:lReembolso,;
							::o790C:lInternacao,;
							::o790C:lEvolucao,;
							cGuiaInter,;
							cGuiaSadt,;
							B53->(B53_CODOPE+B53_CODLDP+B53_CODPEG+B53_NUMERO+B53_ORIMOV),;
							'1',;
							cParecer,;
							oModelD:GetValue( 'B72_SEQPRO' ),;
							RETCODUSR(),;
							PLRETOPE(),;
							oModelD:GetValue( 'B72_QTDAUT' ),;
							oModelD:GetValue( 'B72_VLRAUT' ),;
							"",;
							nil,;
							iIf((cAIte)->(fieldPos(cAIte+"_VIA"))>0,oModelD:GetValue('B72_VIA'),""),;
							iIf((cAIte)->(fieldPos(cAIte+"_PERVIA"))>0,oModelD:GetValue('B72_PERVIA'),0),;
							iIf(cACab == "B4A", .T.,.F.),;
							::o790C:lProrrog )
							
							
				//����������������������������������������������������������������������������
				//� Monta Chave
				//����������������������������������������������������������������������������
				aChave := {}             
				AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cAIte + "_OPEMOV"), '=', Left(B53->B53_NUMGUI,4) } )
				AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cAIte + "_ANOAUT"), '=', SubStr(B53->B53_NUMGUI,5,4) } )
				AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cAIte + "_MESAUT"), '=', SubStr(B53->B53_NUMGUI,9,2)} )
				AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cAIte + "_NUMAUT"), '=', Right(B53->B53_NUMGUI,8)} )
				AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cAIte + "_AUDITO"), '=', "1"} )
				
				aChaveBQV := {}
				AaDd(aChaveBQV, { ::o790C:SetFieldGui("BQV_CODOPE"), '=', Left(B53->B53_NUMGUI,4) 		} )
				AaDd(aChaveBQV, { ::o790C:SetFieldGui("BQV_ANOINT"), '=', SubStr(B53->B53_NUMGUI,5,4) 	} )
				AaDd(aChaveBQV, { ::o790C:SetFieldGui("BQV_MESINT"), '=', SubStr(B53->B53_NUMGUI,9,2) 	} )
				AaDd(aChaveBQV, { ::o790C:SetFieldGui("BQV_NUMINT"), '=', Right(B53->B53_NUMGUI,8) 		} )
				AaDd(aChaveBQV, { ::o790C:SetFieldGui("BQV_AUDITO"), '=', "1" 		} )
				//����������������������������������������������������������������������������
				//� Verifica se ainda tem procedimento a ser analisado
				//����������������������������������������������������������������������������
				oGEN 	 := CABREGIC():New()
				If oGEN:GetCountReg("BQV",aChaveBQV) == 0
					
					If cAIte == "BQV"
						lLastReg := .T.
					Else
						lLastReg := oGEN:GetCountReg(::o790C:cAIte,aChave ) == 0
					EndIf       
		 		Else
		 			
		 			lLastReg := .F.
		 			
		 			Help("",1,FunName(),,"Esta guia ainda possui " + cValToChar( oGEN:GetCountReg("BQV",aChaveBQV)) + " procedimento(s) de evolu��o a ser(em) auditado(s).",1,0)
		 			
				EndIf       
				oGEN:Destroy()
			//EndIf	   
		ENDIF	   
		//����������������������������������������������������������������������������
		//� Interna-Saude
		//����������������������������������������������������������������������������
		Case ::lMDAnaliseGui .And. ::o790C:lIntSau         
			//����������������������������������������������������������������������������
			//� Auditor que fez a analise interna-saude
			//����������������������������������������������������������������������������
			oModelD:SetValue( 'B72_COPERE', RETCODUSR() )         
			//����������������������������������������������������������������������������
			//� Se tiver inconsistente
			//����������������������������������������������������������������������������
			If oModelD:GetValue( 'B72_INCONS' ) == '1'
				//����������������������������������������������������������������������������
				//� Atualiza o cabecalho
				//����������������������������������������������������������������������������
				oB53 := PLSSTRUC():New("B53",MODEL_OPERATION_UPDATE,,B53->( Recno() ) )
					oB53:SetValue("B53_SITUAC","4")
				oB53:CRUD() 
			EndIf
		//����������������������������������������������������������������������������
		//� Resposta ao autidor saude
		//����������������������������������������������������������������������������
		Case ::lMDRespAuditor	
			//����������������������������������������������������������������������������
			//� Verifica se o auditor respondeu alguma vez o questionamento do interna-saude
			//����������������������������������������������������������������������������
			oB72 := CABREGIC():New()
			oB72:GetDadReg("B72",,,B72->( Recno() ) )    
			
			If oB72:GetValue( "B72_RESAUT" ) <> '1'
				oB72 := PLSSTRUC():New("B72",MODEL_OPERATION_UPDATE,,B72->( Recno() ) )
					oB72:SetValue("B72_RESAUT","1")
					oB72:SetValue("B72_RESAUT","1")
				oB72:CRUD()
			EndIf 
			//����������������������������������������������������������������������������
			//� Se for diferente de n�o concordar retira a guia da inconsistencia
			//����������������������������������������������������������������������������
			If oModelD:GetValue( 'B73_TPACAO' ) <> '3'
				//����������������������������������������������������������������������������
				//� Finaliza guia
				//����������������������������������������������������������������������������
				oB72 := PLSSTRUC():New("B72",MODEL_OPERATION_UPDATE,,B72->( Recno() ) )
				oB72:SetValue("B72_INCONS","3")
				oB72:CRUD() 
				//����������������������������������������������������������������������������
				//� Monta Chave
				//����������������������������������������������������������������������������
				aChave := {}             
				AadD(aChave, { "B72_ALIMOV", '=', B53->B53_ALIMOV } )		
				AadD(aChave, { "B72_RECMOV", '=', B53->B53_RECMOV } )		
				AadD(aChave, { "B72_INCONS", '=', "1" } )		
				//����������������������������������������������������������������������������
				//� Verifica se ainda tem procedimento a ser analisado
				//����������������������������������������������������������������������������
				oGEN := CABREGIC():New()
				If oGEN:GetCountReg("B72",aChave ) == 0
					//����������������������������������������������������������������������������
					//� Atualiza o cabecalho
					//����������������������������������������������������������������������������
					oB53 := PLSSTRUC():New("B53",MODEL_OPERATION_UPDATE,,B53->( Recno() ) )
						oB53:SetValue("B53_SITUAC","1")
					oB53:CRUD() 
				EndIf	
				oGEN:Destroy()
			EndIf
		EndCase	
//����������������������������������������������������������������������������
//� Quando for exclusao 
//����������������������������������������������������������������������������
ElseIf nOperation == MODEL_OPERATION_DELETE
	//����������������������������������������������������������������������������
	//� Verifica se tem banco de conhecimento e exclui
	//����������������������������������������������������������������������������
	MsDocument( cAlias, (cAlias)->( Recno() ), 2, , 3)
	//����������������������������������������������������������������������������
	//� Participariva
	//����������������������������������������������������������������������������
	If ::lMDParticipativa .And. ::o790C:lAgendada	
		//����������������������������������������������������������������������������
		//� Atualiza o pai retirando o agendamento da guia
		//����������������������������������������������������������������������������
		oB53 := PLSSTRUC():New("B53",MODEL_OPERATION_UPDATE,,B53->( Recno() ))  
		oB53:SetValue("B53_AGEPAR","0" )
		oB53:CRUD() 
	EndIf
EndIf	    
//����������������������������������������������������������������������������
//� Commit 
//����������������������������������������������������������������������������
FWFormCommit( oModel )

oB72 := PLSSTRUC():New( "B72",MODEL_OPERATION_UPDATE,,B72->( Recno() ) )
		oB72:SetValue("B72_DATMOV",dDataBase)
		BE2->(dbSetOrder(1))
		If BE2->(dbSeek(xFilial("BE2")+B53->B53_NUMGUI))		
			oB72:SetValue("B72_QTDAUT",BE2->BE2_QTDPRO)
		EndIf
		
		///IF (::o790C:lRotinaGen) 
			aTmp := SEPARA(B53->B53_CVLAUD, ",",.F.)
			
			//Como est� posicionado no item da tabela, j� informo que n�o est� mais em auditoria
			(::o790C:cAite)->(RecLock(::o790C:cAite,.F.))
			(::o790C:cAite)->&(::o790C:cAite+"_"+aTmp[1]) := aTmp[4]
			(::o790C:cAite)->(MsUnlock())
			
			//Verifico se para esta tabela foi colocado alguma informa��o de campo de Parecer ou n�o. Se sim, atualizo conforme
			//dados do vetor aTmp , proveniente do campo B53_CVLAUD
			IF ( Len(aTmp) > 5)  //Significa que na tabela tem algum campo que armazena o parecer tamb�m e necessita de atualiza��o
				   DO CASE 
				   Case (oModelD:GetValue('B72_PARECE') == "0")
                   (::o790C:cAite)->(RecLock(::o790C:cAite,.F.))	
				     (::o790C:cAite)->&(::o790C:cAite+"_"+aTmp[5]) := aTmp[6]  
				     (::o790C:cAite)->(MsUnlock())
				   CASE (oModelD:GetValue('B72_PARECE') == "1")
				     (::o790C:cAite)->(RecLock(::o790C:cAite,.F.))
				     (::o790C:cAite)->&(::o790C:cAite+"_"+aTmp[5]) := aTmp[7]
				     (::o790C:cAite)->(MsUnlock())	
				   ENDCASE  
			ENDIF
			(::o790C:cAite)->(DbSetOrder(1))	
			
			//Verifico se para esta guia ainda temos mais procedimentos em auditoriae se j� foram auditados
			IF ( (::o790C:cAite)->(MsSeek(xfilial(::o790C:cAite)+Alltrim(B53->B53_NUMGUI))) )
			  cInd := PLSVerInd(1, .T.)
			  cInd := Substr(cInd,0,Len(cInd)-1)
			  WHILE ( !(::o790C:cAite)->(EOF()) .AND. (::o790C:cAite)->&(cInd) == xFilial(::o790C:cAite)+ Alltrim(B53->B53_NUMGUI)) 
			  	IF ( (::o790C:cAite)->&(::o790C:cAite+"_"+aTmp[1]) == aTmp[2] )
			      nSom += 1
			    ENDIF   
			   (::o790C:cAite)->(DbSkip()) 
			  ENDDO  
			ENDIF  
			
			IF (nSom == 0)
			  (cACab)->(RecLock(cACab,.F.))	
			  (cACab)->&(cACab+"_"+aTmp[1]) := aTmp[4]
			  (::o790C:cAite)->(MsUnlock())
			  B53->(RecLock("B53", .F.))
			  B53->B53_SITUAC := "1"
			  B53->B53_OPERAD := ""
			  B53->(MsUnlock())
			ENDIF
		//  ENDIF	   

		
		oB72:CRUD()
		oB72:Destroy()
//����������������������������������������������������������������������������
//� Verifica se foi selecionado a opcao todos 
//����������������������������������������������������������������������������
For nI:=1 To Len(aMatGlo)
	//����������������������������������������������������������������������������
	//� Somente glosa que ainda nao foi inserida na B72
	//����������������������������������������������������������������������������
	If oModelD:GetValue('B72_CODGLO') <> aMatGlo[nI]
		//����������������������������������������������������������������������������
		//� Verifica se ja existe na base
		//����������������������������������������������������������������������������
		oGEN := CABREGIC():New()
		oGEN:GetDadReg("B72",1 ,xFilial("B72") + B53->(B53_ALIMOV+B53_RECMOV) + oModelD:GetValue('B72_SEQPRO') + aMatGlo[nI] ,,,.F. )
	
		If oGEN:lFound
			oB72 := PLSSTRUC():New("B72",MODEL_OPERATION_UPDATE,,B72->( Recno() ))  
				oB72:SetValue("B72_PARECE",oModelD:GetValue('B72_PARECE') )
				oB72:SetValue("B72_OBSANA",oModelD:GetValue('B72_OBSANA') )
				oB72:SetValue("B72_MOTIVO",oModelD:GetValue('B72_MOTIVO') )
				oB72:SetValue("B72_VLRAUT",oModelD:GetValue('B72_VLRAUT') )
				oB72:SetValue("B72_QTDAUT",oModelD:GetValue('B72_QTDAUT') )
				oB72:SetValue("B72_VIA",oModelD:GetValue('B72_VIA') )
				oB72:SetValue("B72_PERVIA",oModelD:GetValue('B72_PERVIA') )
			oB72:CRUD()
		Else
			oB72 := PLSSTRUC():New("B72",MODEL_OPERATION_INSERT,,B72->( Recno() ))  
			oB72:SetValue("B72_FILIAL",oModelD:GetValue('B72_FILIAL') )	
			oB72:SetValue("B72_TPPARE",oModelD:GetValue('B72_TPPARE') )	
			oB72:SetValue("B72_ALIMOV",oModelD:GetValue('B72_ALIMOV') )
			oB72:SetValue("B72_RECMOV",oModelD:GetValue('B72_RECMOV') )
			oB72:SetValue("B72_DATMOV",dDataBase )
			oB72:SetValue("B72_CODPRO",oModelD:GetValue('B72_CODPRO') )
			oB72:SetValue("B72_OPERAD",oModelD:GetValue('B72_OPERAD') )
			oB72:SetValue("B72_CODGLO",aMatGlo[nI])
			oB72:SetValue("B72_OBSISA",oModelD:GetValue('B72_OBSISA') )
			oB72:SetValue("B72_SEQPRO",oModelD:GetValue('B72_SEQPRO') )
			oB72:SetValue("B72_CODPAD",oModelD:GetValue('B72_CODPAD') )
			oB72:SetValue("B72_PARECE",oModelD:GetValue('B72_PARECE') )
			oB72:SetValue("B72_ACOTOD",oModelD:GetValue('B72_ACOTOD') )
			oB72:SetValue("B72_OBSANA",oModelD:GetValue('B72_OBSANA') )
			oB72:SetValue("B72_MOTIVO",oModelD:GetValue('B72_MOTIVO') )
			oB72:SetValue("B72_VLRAUT",oModelD:GetValue('B72_VLRAUT') )
			oB72:SetValue("B72_QTDAUT",oModelD:GetValue('B72_QTDAUT') )
			oB72:SetValue("B72_RESAUT",oModelD:GetValue('B72_RESAUT') )
			oB72:SetValue("B72_COPERE",oModelD:GetValue('B72_COPERE') )
			oB72:SetValue("B72_INCONS",oModelD:GetValue('B72_INCONS') )
			oB72:SetValue("B72_TPINCO",oModelD:GetValue('B72_TPINCO') )
			oB72:SetValue("B72_TPINCO",oModelD:GetValue('B72_TPINCO') )
			oB72:SetValue("B72_VIA",oModelD:GetValue('B72_VIA') )
			oB72:SetValue("B72_PERVIA",oModelD:GetValue('B72_PERVIA') )
			oB72:CRUD()
		EndIf         
		
		oGEN:Destroy()
	EndIf		
Next
//����������������������������������������������������������������������������
//� Na inclusao ou alteracao
//����������������������������������������������������������������������������
If nOperation == MODEL_OPERATION_INSERT .Or. nOperation = MODEL_OPERATION_UPDATE
	
	//����������������������������������������������������������������������������
	//� ANALISE DA CRITICA - GUIA
	//� Se for o ultimo registro e nao tiver nenhuma critica pendente atualiza a guia
	//����������������������������������������������������������������������������
	If lLastReg .And. ::lMDAnaliseGui .And. !::o790C:lIntSau
		
		//����������������������������������������������������������������������������
		//� Atualiza o cabecalho
		//����������������������������������������������������������������������������
		oB53 := PLSSTRUC():New("B53",MODEL_OPERATION_UPDATE,,B53->( Recno() ) )
		//����������������������������������������������������������������������������
		//� Verifica analise do auditor B72_FILIAL + B72_ALIMOV + B72_RECMOV + B72_PARECE
		//����������������������������������������������������������������������������
		oB72 := CABREGIC():New()
		oB72:GetDadReg("B72",3, xFilial("B72") + B53->(B53_ALIMOV+B53_RECMOV)+"2",,,.F. )    
		//����������������������������������������������������������������������������
		//� Se esta em analise 0=Autorizado; 1=Negado; 2=Em Analise
		//����������������������������������������������������������������������������
		If oB72:lFound	
			oB53:SetValue("B53_SITUAC","2",,,.F. )  //0=N�o;1=Sim;2=Em Analise;3=Em Espera;4=Inconsist�ncia
		Else   
			//����������������������������������������������������������������������������
			//� Autorizado
			//����������������������������������������������������������������������������
			oB72:GetDadReg("B72",3, xFilial("B72") + B53->(B53_ALIMOV+B53_RECMOV)+"0",,,.F.)    
			lAutorizado := oB72:lFound	
			//����������������������������������������������������������������������������
			//� Negado
			//����������������������������������������������������������������������������
			oB72:GetDadReg("B72",3, xFilial("B72") + B53->(B53_ALIMOV+B53_RECMOV)+"1",,,.F. )    
			lNegado := oB72:lFound	
			//����������������������������������������������������������������������������
			//Verifica��o Adicional caso seja apenas lNegado. Podemos ter na guia 2 ou mais procedimentos e todos estarem autorizados e apenas 1 foi para auditoria e este foi negado.
			//Nesse caso, o sistema vai identificar que � o �ltimo registro e negado e a guia vai ficar como negada, sendo que na verdade, est� autorizada parcialmente.
			//Assim, para acompanhar o status da guia, al�m de verificar na B72 a situa��o, iremos verificar tamb�m na tabela de itens os status dos procedimentos.
			//����������������������������������������������������������������������������
			if lNegado	.and. !lAutorizado	
				lAutorizado := VeriteAtB53()	
			EndIf
			//����������������������������������������������������������������������������
			//� Verifica se tem algum registro autorizado
			//����������������������������������������������������������������������������
			If lAutorizado .And. lNegado
				oB53:SetValue("B53_STATUS","2") //1=Autorizada;2=Aut. Parcial;3=Nao Autorizada;4=Finaliza��o Atendimento;5=Liq. Titulo a Receber
			ElseIf lAutorizado	
				oB53:SetValue("B53_STATUS","1")
			ElseIf lNegado
				oB53:SetValue("B53_STATUS","3")
			EndIf
			//����������������������������������������������������������������������������
			//� Coloca a guia como analisada e data e hora do final geral da analise
			//����������������������������������������������������������������������������
			oB53:SetValue("B53_SITUAC","1" ) 
		 	oB53:SetValue("B53_OPERAD",'')
			oB53:SetValue("B53_DATFIM",dDataBase)
			oB53:SetValue("B53_HORFIM",Left(Time(),5))
			
			//����������������������������������������������������������������������������
			//� Atualiza Dados da Internacao
			//����������������������������������������������������������������������������
			If AllTrim(B53->B53_TIPO) == "3" .And. M->B72_PARECE $ "0,1" 
				BE4->(dbSetOrder(2))
				If dbSeek(xFilial("BE4")+ B53->B53_NUMGUI)
					oBE4 := PLSSTRUC():New( "BE4",MODEL_OPERATION_UPDATE,,BE4->( Recno() ) )
					If ::o790C:lEvolucao
						//����������������������������������������������������������������������������
						//� Atualiza dados da Guia caso for Evolucao
						//����������������������������������������������������������������������������
						//Status
						If lAutorizado .And. lNegado
							oBE4:SetValue("BE4_STATUS","2") //Aut. Parcial
							oBE4:SetValue("BE4_STTISS","7") 
						
						ElseIf lAutorizado	
							oBE4:SetValue("BE4_STATUS","1") //Autorizada
							oBE4:SetValue("BE4_STTISS","1") 
						
						ElseIf lNegado
							oBE4:SetValue("BE4_STATUS","3") //Nao Autorizada
							oBE4:SetValue("BE4_STTISS","5") 
						EndIf
					Else

						//Data de validade da Internacao
						dData := dDataBase + GETMV("MV_PLPRZLB")
						oBE4:SetValue("BE4_DATVAL",dData)
					EndIf

					oBE4:CRUD()
					oBE4:Destroy()
				EndIf
			EndIf
			//����������������������������������������������������������������������������
			//� Atualiza a data de aprova��o
			//����������������������������������������������������������������������������
			oBEA := PLSSTRUC():New( "BEA",MODEL_OPERATION_UPDATE,,BEA->( Recno() ) )
			oBEA:SetValue("BEA_DATPRO",dDataBase)
			//Ponto de entrada para altera��o da Data de Altera��o
			If ExistBlock("PLALTDTPR")			
				oBEA := ExecBlock("PLALTDTPR", .F., .F., {oBEA} ) 
			Endif
			
			oBEA:CRUD()
			oBEA:Destroy()
			
			//Atualiza o campo cAudito da guia
			oRegGui := PLSSTRUC():New(::o790C:cACab, MODEL_OPERATION_UPDATE,,(::o790C:cACab)->( Recno() ) )
			oRegGui:SetValue(::o790C:cACab + "_AUDITO","0")
			oRegGui:CRUD()
			oRegGui:Destroy()
			
        EndIf
		//����������������������������������������������������������������������������
		//� Grava e destroy as classes
		//����������������������������������������������������������������������������
		oB53:CRUD()  
		oB53:Destroy()
		oB72:Destroy()
	//����������������������������������������������������������������������������
	//� Interna-Saude
	//����������������������������������������������������������������������������
	ElseIf ::lMDAnaliseGui .And. ::o790C:lIntSau .And. oModelD:GetValue( 'B72_INCONS' ) == '3'         
		aChave := {}
		AadD(aChave, { "B72_ALIMOV", '=', B53->B53_ALIMOV } )		
		AadD(aChave, { "B72_RECMOV", '=', B53->B53_RECMOV } )
		AadD(aChave, { "B72_INCONS", '=', "1" } )		
		//����������������������������������������������������������������������������
		//� Verifica se ainda tem procedimento a ser analisado
		//����������������������������������������������������������������������������
		oGEN := CABREGIC():New()
		If oGEN:GetCountReg("B72",aChave ) == 0
			//����������������������������������������������������������������������������
			//� Atualiza o cabecalho
			//����������������������������������������������������������������������������
			oB53 := PLSSTRUC():New("B53",MODEL_OPERATION_UPDATE,,B53->( Recno() ) )
				oB53:SetValue("B53_SITUAC","1")
			oB53:CRUD() 
		EndIf     
		oGEN:Destroy()
    EndIf
EndIf    
//����������������������������������������������������������������������������
//� Rest nas linhas do browse e na area										 
//����������������������������������������������������������������������������
RestArea( aArea )                   
//����������������������������������������������������������������������������
//� Fim da Rotina															 
//����������������������������������������������������������������������������
Return(.T.)


//-------------------------------------------------------------------
/*/ { Protheus.doc } MDActVLD
Validacao da Ativacao do modelo

@author Alexander Santos 
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD MDActVLD(oModel) Class CABPADRC
LOCAL lRet			:= .T.           
LOCAL cPerfil	 	:= ""
LOCAL nOperation 	:= oModel:GetOperation()
LOCAL oGEN		 	:= NIL
//����������������������������������������������������������������������������
//� Atualiza informacoes da classe
//����������������������������������������������������������������������������
AtuPClass(Self)
//���������������������������������������������������������������������������
//� Valida se o browse pai tem registro										 
//���������������������������������������������������������������������������
If !::o790C:lHaveGuia
	_Super:ExbMHelp( "Imposs�vel realizar esta opera��o" ) //"Imposs�vel realizar esta opera��o"
	lRet := .F.
Else
	//����������������������������������������������������������������������������
	//� Verifica se tem acesso a guia e operacao diferente de visualizar
	//����������������������������������������������������������������������������
	If oModel:GetOperation() <> 1
		lRet := ::o790C:VldAcessoGui()
	EndIf	                                                                      
	//����������������������������������������������������������������������������
	//� Verifica o modelo que esta acessando o controle
	//����������������������������������������������������������������������������
	Do Case
		//����������������������������������������������������������������������������
		//� Demanda
		//����������������������������������������������������������������������������
		Case ::lMDDemanda .And. !::o790C:lIntSau
			//����������������������������������������������������������������������������
			//� Somente se for registro de demanada
			//����������������������������������������������������������������������������
			If lRet .And. !::o790C:lDemanda
				_Super:ExbMHelp( "Somente guia de Demanda") //"Somente guia de Demanda"
				lRet := .F.
			EndIf                
			//����������������������������������������������������������������������������
			//� Somente se for o mesmo operador.
			//����������������������������������������������������������������������������
			If lRet .And. nOperation == MODEL_OPERATION_UPDATE .And. !::lEditaProcesso
				lRet := ::VldRegOwner()
			EndIf
		//����������������������������������������������������������������������������
		//� Encaminhamento
		//����������������������������������������������������������������������������
		Case ::lMDEncaminhamento .And. !::o790C:lIntSau
			//����������������������������������������������������������������������������
			//� Somente se for registro de encaminhamento
			//����������������������������������������������������������������������������
			If lRet .And. nOperation == MODEL_OPERATION_UPDATE
				lRet := ::VldRegOwner()
			EndIf
		//����������������������������������������������������������������������������
		//� Participativa
		//����������������������������������������������������������������������������
		Case ::lMDParticipativa .And. !::o790C:lIntSau
			//����������������������������������������������������������������������������
			//� Se a guia e participativa
			//����������������������������������������������������������������������������
			If lRet .And. !::o790C:lParticipativa
				_Super:ExbMHelp( "Somente guia Participativa") //"Somente guia Participativa"
				lRet := .F.
			EndIf	
			//����������������������������������������������������������������������������
			//� Se o operador e o dono da guia
			//����������������������������������������������������������������������������
			If lRet .And. nOperation == MODEL_OPERATION_UPDATE
				lRet := ::VldRegOwner()
			EndIf                                
			//����������������������������������������������������������������������������
			//� Verifica se a guia ja esta agendada
			//����������������������������������������������������������������������������
			If lRet .And. ::o790C:lAgendada .And. ( nOperation == MODEL_OPERATION_UPDATE .Or. nOperation == MODEL_OPERATION_INSERT )
				_Super:ExbMHelp( "Esta guia j� esta agendada, exclua o agendamento antes!") //"Esta guia j� esta agendada, exclua o agendamento antes!"
				lRet := .F.
			EndIf
		//����������������������������������������������������������������������������
		//� Analise e nao e interna-saude
		//����������������������������������������������������������������������������
		Case ::lMDAnaliseGui .And. !::o790C:lIntSau .AND. !::o790C:lRotinaGen
            
            If Empty( (::o790C:cACri)->&(::o790C:cACri+"_CODGLO") )
				_Super:ExbMHelp("A critica n�o esta selecionada!")//"A critica n�o esta selecionada!"
				lRet := .F.
            Else   
    			If (::o790C:cACri)->( FieldPos(::o790C:cACri + "_TIPO") ) > 0 .And. !Empty( (::o790C:cACri)->&( ::o790C:cACri + "_TIPO" ) )
					cPerfil := (::o790C:cACri)->&( ::o790C:cACri + "_TIPO" )
				Else	
					oGEN := CABREGIC():New()
					oGEN:GetDadReg( "BCT",1, xFilial("BCT") + B53->B53_CODOPE + (::o790C:cACri)->&(::o790C:cACri+"_CODGLO") )
					cPerfil := oGEN:GetValue("BCT_TIPO")
			        oGEN:Destroy()
				EndIf	
				//����������������������������������������������������������������������������
				//� Se esta em analise 0=Autorizado;1=Negado;2=Em Analise
				//����������������������������������������������������������������������������
			  	If ::o790C:cPerfil <> PLS_ADMINITRADOR .And. ::o790C:cPerfil <> cPerfil
					_Super:ExbMHelp( "Selecione uma critica correspondente ao ser perfil!" ) //"Selecione uma critica correspondente ao ser perfil!"
					lRet := .F.
				EndIf
		                        
		    EndIf    
		//����������������������������������������������������������������������������
		//� Interna-saude
		//����������������������������������������������������������������������������
		Case ::lMDAnaliseGui .And. ::o790C:lIntSau
			//����������������������������������������������������������������������������
			//� Alteracao
			//����������������������������������������������������������������������������
			If nOperation == MODEL_OPERATION_UPDATE
				//����������������������������������������������������������������������������
				//� Verifica se e o owner do lancamento
				//����������������������������������������������������������������������������
				lRet := ::VldRegOwner(.T.)
				//����������������������������������������������������������������������������
				//� Verifica se este registro tem inconsistencia
				//����������������������������������������������������������������������������
				If lRet .And. ::lIntSaudInco
					_Super:ExbMHelp( "J� foi sinalizando para o auditor respons�vel ou j� finalizada!") //"J� foi sinalizando para o auditor respons�vel ou j� finalizada!"
					lRet := .F.
				EndIf
			EndIf	
	EndCase	
EndIf          
//����������������������������������������������������������������������������
//� Fim da Rotina															 
//����������������������������������������������������������������������������
Return(lRet)
//-------------------------------------------------------------------
/*/ { Protheus.doc } MDCancelVLD
Validacao do botao cancel do modelo

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD MDCancelVLD(oGEN,cAlias) Class CABPADRC
LOCAL lRet 		:= .T.
DEFAULT oGEN	:= NIL      
DEFAULT cAlias 	:= ""
//���������������������������������������������������������������������������������������
//� Fecha o link documento caso exista
//���������������������������������������������������������������������������������������
If ValType( oLinkWord ) == "O" 
	If ValType( oGEN ) == "U" 
		oGEN := PLSMACRC():New()
	EndIf	
	oGEN:CloseDoc(oLinkWord:oWord)
EndIf        
//���������������������������������������������������������������������������������������
//� Aborta os SX8 gerados sem confirmacao
//���������������������������������������������������������������������������������������
RollBackSX8()
//����������������������������������������������������������������������������
//� Fim da Rotina															 
//����������������������������������������������������������������������������
Return(lRet)            
//-------------------------------------------------------------------
/*/ { Protheus.doc } VWActBDocPro
Acao do botao ok da view

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD VWActBDocPro(oView, oButton) Class CABPADRC
LOCAL lRet := .T.
LOCAL oGEN := PLSMACRC():New()
//���������������������������������������������������������������������������������������
//� Fecha o link documento caso exista
//���������������������������������������������������������������������������������������
::MDCancelVLD(oGEN)
//���������������������������������������������������������������������������������������
//� Mostra documento padrao - DOT (View acessando Controle para pegar o modelo)
//���������������������������������������������������������������������������������������
oLinkWord := oGEN:GetDocPro()
oGEN:Destroy()
//��������������������������������������������������������������������������Ŀ
//� Fim da Rotina															 �
//����������������������������������������������������������������������������
Return(lRet)                       
//-------------------------------------------------------------------
/*/ { Protheus.doc } VWListProc
Acao do botao de Lista do procedimento

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD VWListProc( oView, oButton, cAlias ) Class CABPADRC                            
LOCAL aArea   	:= GetArea()
LOCAL nI	  	:= 1
LOCAL nQtd	  	:= 0
LOCAL nRec 	:= (::o790C:cAIte)->( Recno() )
LOCAL cChave  	:= ""
LOCAL cProc	:= "" 
LOCAL lRet	  	:= .T.
LOCAL aMatCol 	:= {}
LOCAL aMatLin	:= {}
LOCAL aMatPro	:= {}
LOCAL oModelD 	:= oView:oModel:GetModel( oView:oModel:GetModelIds()[1] )
//����������������������������������������������������������������������������
//� Colunas
//����������������������������������������������������������������������������
AaDd( aMatCol,{ "C�digo"      ,'@!',30} )
AaDd( aMatCol,{ "Procedimento",'@!',120} )
//����������������������������������������������������������������������������
//� Posiciona no registro
//����������������������������������������������������������������������������
cChave := xFilial(::o790C:cAIte) + B53->B53_NUMGUI

oGEN := CABREGIC():New()
oGEN:GetDadReg(::o790C:cAIte,1, cChave )

If oGEN:lFound
	//����������������������������������������������������������������������������
	//� Monta lista de procedimentos
	//����������������������������������������������������������������������������
	While !(::o790C:cAIte)->( Eof() ) .And. cChave == xFilial(::o790C:cAIte)+(::o790C:cAIte)->&( ::o790C:SetFieldGui(::o790C:cAIte+"_OPEMOV+"+::o790C:cAIte+"_ANOAUT+"+::o790C:cAIte+"_MESAUT+"+::o790C:cAIte+"_NUMAUT") )
	
		AaDd( aMatLin, { (::o790C:cAIte)->&( ::o790C:cAIte+"_CODPRO" ) , (::o790C:cAIte)->&( ::o790C:cAIte+"_DESPRO" ), .F. } )
		
	(::o790C:cAIte)->( DbSkip() )
	EndDo
	
EndIf

oGEN:Destroy()
//����������������������������������������������������������������������������
//� Pega lista
//����������������������������������������������������������������������������
cProc := StrTran(AllTrim( oModelD:GetValue(cAlias + "_LISPRO") ),Chr(10),"")
//����������������������������������������������������������������������������
//� Coloca a lista em uma matriz
//����������������������������������������������������������������������������
oGEN 	:= PLSCONTR():New()
aMatPro := oGEN:Split(',', cProc )
oGEN:Destroy()
//����������������������������������������������������������������������������
//� Marca os itens ja selecionados
//����������������������������������������������������������������������������
For nI:=1 To Len(aMatPro)

	If (nPos := Ascan( aMatLin,{|x| AllTrim(x[1]) == AllTrim(aMatPro[nI]) } ) ) > 0
		aMatLin[ nPos ,Len( aMatLin[nPos] ) ] := .T.
	EndIf                     

Next
//����������������������������������������������������������������������������
//� Lista de procedimento
//����������������������������������������������������������������������������
PLSSELOPT( "Lista de Procedimentos", "Marca e Desmarca todos", aMatLin, aMatCol, MODEL_OPERATION_INSERT,.F.,.T.,.F.,.T.,"Procedimento : ",1 )
//����������������������������������������������������������������������������
//� Retorna o Recno
//����������������������������������������������������������������������������
(::o790C:cAIte)->( DbGoTo(nRec) )                                 

cProc := ""
//����������������������������������������������������������������������������
//� Verifica itens selecionado
//����������������������������������������������������������������������������
For nI := 1 To Len(aMatLin) 
	If aMatLin[nI,3]
		nQtd++
		cProc += AllTrim(aMatLin[nI,1]) + ","
		If nQtd = 8
			nQtd := 0
			cProc += Chr(10)
		EndIf			
	EndIf
Next                
//����������������������������������������������������������������������������
//� Atualiza Lista
//����������������������������������������������������������������������������
oModelD:SetValue( cAlias + "_LISPRO", Left( cProc,Len(cProc)-1 ) )
//����������������������������������������������������������������������������
//� Rest nas linhas do browse e na area										 
//����������������������������������������������������������������������������
RestArea( aArea )                   
//���������������������������������������������������������������������������
//� Fim da Rotina															 
//���������������������������������������������������������������������������
Return(lRet)                       
//-------------------------------------------------------------------
/*/ { Protheus.doc } VWOkCloseScreenVLD
Faz validacao para fechar a tela ou nao .T. Fecha .F nao deixa fechar a tela

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD VWOkCloseScreenVLD(oView,lExiMsg) Class CABPADRC
LOCAL lRet 	  	:= .T.
LOCAL oModelD 	:= oView:oModel:GetModel( oView:oModel:GetModelIds()[1] )
DEFAULT lExiMsg	:= .T.
//����������������������������������������������������������������������������
//� Se for participativa
//����������������������������������������������������������������������������
If ::lMDParticipativa .And. oModelD:GetValue("B70_RELCON") <> '1' 
	
	lExiMsg := .F.		
EndIf

If lExiMsg
	dbSelectArea("BE2")
	dbSetOrder(1)
	
	If dbSeek(xFilial("BE2")+B53->B53_NUMGUI)
		
		While BE2->(BE2_FILIAL + BE2_OPEMOV + BE2_ANOAUT + BE2_MESAUT + BE2_NUMAUT) ==  xFilial("BE2")+B53->B53_NUMGUI
			
			If BE2->BE2_AUDITO == "1"
				lExiMsg := .F.
				EXIT
			EndIf
			
			BE2->(dbSkip())
		EndDo
	EndIf
EndIf
//����������������������������������������������������������������������������
//� Mensagem ao usuario
//����������������������������������������������������������������������������
If lExiMsg .And. oView:GetOperation() <> MODEL_OPERATION_DELETE
	_Super:ExbMHelp( "Esta guia n�o esta mais em Analise! Opera��o concluida com Sucesso!" ) //"Esta guia n�o esta mais em Analise! Opera��o concluida com Sucesso!"
EndIf
//����������������������������������������������������������������������������
//� Atualiza o browse
//����������������������������������������������������������������������������
PLS790OST()
//����������������������������������������������������������������������������
//� Fim da Rotina															 
//����������������������������������������������������������������������������
Return(lRet)                          
//-------------------------------------------------------------------
/*/ { Protheus.doc } VWOkButtonVLD
Faz validacao para fechar a tela ou nao
 .T. Fecha

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD VWOkButtonVLD(oModel,cAlias,cModelDet, lFluig) Class CABPADRC
LOCAL lRet 	 	:= .T.
LOCAL nRecIte	:= 0
LOCAL aChave 	:= {}
LOCAL oGEN	 	:= NIL
LOCAL oModelD	:= oModel:GetModel( oModel:GetModelIds()[1] )
DEFAULT lFluig := .F.


 
If lFluig
	If !Empty(cModelDet) // passa o nome do model usado na estrutura de detalhes (FLUIG)
		oModelD 	 := oModel:GetModel( cModelDet )
	ELse
		oModelD 	 := oModel:GetModel( oModel:GetModelIds()[1] )
	EndIF
EndIf

//IF (!::o790C:lRotinaGen)
	//����������������������������������������������������������������������������
	//� Analise da guia
	//����������������������������������������������������������������������������
	If ::lMDAnaliseGui
		//����������������������������������������������������������������������������
		//� Se for interna saude
		//����������������������������������������������������������������������������
		If ::o790C:lIntSau 
		
			If oModelD:GetValue(cAlias+"_INCONS") == "1" .And. Empty( oModelD:GetValue(cAlias+"_TPINCO") )
				_Super:ExbMHelp( "Informe o tipo da Inconsist�ncia!" ) //"Informe o tipo da Inconsist�ncia!"
				lRet := .F.                                  
			EndIf                                              
		//����������������������������������������������������������������������������
		//� Analise ope/tec/adm
		//����������������������������������������������������������������������������
		Else
			//����������������������������������������������������������������������������
			//� Monta Chave
			//����������������������������������������������������������������������������
			If !::lLastReg 
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cAIte + "_OPEMOV"), '=', Left(B53->B53_NUMGUI,4) } )
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cAIte + "_ANOAUT"), '=', SubStr(B53->B53_NUMGUI,5,4) } )
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cAIte + "_MESAUT"), '=', SubStr(B53->B53_NUMGUI,9,2)} )
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cAIte + "_NUMAUT"), '=', Right(B53->B53_NUMGUI,8)} )
			AaDd(aChave, { ::o790C:SetFieldGui(::o790C:cAIte + "_AUDITO"), '=', "1"} )
				//����������������������������������������������������������������������������
				//� Instancia da classe de acesso a banco
				//����������������������������������������������������������������������������
				oGEN := CABREGIC():New()
				//����������������������������������������������������������������������������
				//� Se for o ultimo registro
				//����������������������������������������������������������������������������
			::lLastReg := ( oGEN:GetCountReg(::o790C:cAIte,aChave ) == 0 )
				
				oGEN:Destroy()
			EndIf	   
			//����������������������������������������������������������������������������
			//� Verifica se ja foi analisada por algum operador
			//����������������������������������������������������������������������������
			If !Empty( (::o790C:cACri)->&( ::o790C:cACri+"_OPERAD" ) ) .And. ::o790C:cOwner != (::o790C:cACri)->&( ::o790C:cACri+"_OPERAD" )
				_Super:ExbMHelp( "Aten��o"+CRLF+"Analise ja iniciada por outro operador!" ) //"Aten��o"###"Analise ja iniciada por outro operador!"
				lRet := .F.
			EndIf
			//����������������������������������������������������������������������������
			//� Autorizado
			//����������������������������������������������������������������������������
			If oModelD:GetValue( 'B72_PARECE' ) $ '0,1,2'
				//����������������������������������������������������������������������������
				//� Verfica se o motivo foi informado
				//����������������������������������������������������������������������������
				If oModelD:GetValue( 'B72_PARECE' ) == '1' 
					If Empty( oModelD:GetValue("B72_MOTIVO") )
						MSGALERT( "Aten��o"+CRLF+"Favor informar o Motivo!" ) //"Aten��o"###"Favor informar o Motivo!"
						lRet := .F.
					EndIf
				Endif
				If oModelD:GetValue( 'B72_PARECE' ) == '1' 
					If Empty( oModelD:GetValue("B72_MOTIVO") )
						MSGALERT( "Aten��o"+CRLF+"Esta guia n�o esta mais em Analise! Opera��o concluida com Sucesso!" ) //"Aten��o"###"Informe no campo Motivo a raz�o do procedimento ser Negado!"
						lRet := .F.
					EndIf
				Endif
				//*********************
				If oModelD:GetValue( 'B72_PARECE' ) == '2' 
					If Empty( oModelD:GetValue("B72_OBSANA") )
						MSGALERT( "Aten��o"+CRLF+"Nenhum dado foi alterado. Se n�o deseja dar um parecer, utilize o bot�o Cancelar." ) //"Aten��o"###"Nenhum dado foi alterado. Se n�o deseja dar um parecer, utilize o bot�o Cancelar."
						lRet := .F.	
					EndIf		
				Endif	
				
				If ::o790C:lCriDia .and. oModelD:GetValue( 'B72_PARECE' ) == '0' 
					If Empty( oModelD:GetValue("B72_DIAAUT") )
						
						MSGALERT( "Aten��o"+CRLF+"Informe o campo com a quantidade de di�rias autorizadas" ) //"Aten��o"###"Informe no campo Motivo a raz�o do procedimento ser Negado!"
						lRet := .F.
				
					ElseIf oModelD:GetValue("B72_DIASOL") < oModelD:GetValue("B72_DIAAUT")
						
						MSGALERT( "Aten��o"+CRLF+"Quantidade solicitada menor do que a autorizada." ) //"Aten��o"###"Informe no campo Motivo a raz�o do procedimento ser Negado!"
						lRet := .F.

					Else 
						lRet := MsgYesNo("Ao autorizar este procedimento, todas as cr�ticas ser�o exclu�das! Deseja realmente autorizar? ")
					EndIf
				Endif
						
				//����������������������������������������������������������������������������
				//� Verifica se foi informado valor e qtd
				//����������������������������������������������������������������������������
				If ::lLastReg .And. ( oModelD:GetValue( 'B72_QTDAUT' ) == 0 .Or. ( oModelD:IsFieldUpdated("B72_VLRAUT") .And. oModelD:GetValue( 'B72_VLRAUT' ) == 0 ) )
					_Super:ExbMHelp( "Verifique o conteudo informado na quantidade e valor" ) //"Verifique o conteudo informado na quantidade e valor"
					lRet := .F.                                  
				EndIf  
				//����������������������������������������������������������������������������
				//� Verifica se tem liberacao e se o saldo esta conforme a quantidade autorizada
				//����������������������������������������������������������������������������
				If ::o790C:lSadt .And. lRet  
					//����������������������������������������������������������������������������
					//� Numero da liberacao
					//����������������������������������������������������������������������������
					cNum := _Super:RetConCP(::o790C:cAIte,"NRLBOR")
					
					If ::lLastReg .And. !Empty(cNum)
						//����������������������������������������������������������������������������
						//� Salva posicao do registro
						//����������������������������������������������������������������������������
					    nRecIte := ( ::o790C:cAIte )->( Recno() )
						//����������������������������������������������������������������������������
						//� Limpa o filtro
						//����������������������������������������������������������������������������
						( ::o790C:cAIte )->( DbClearFilter() )
						//����������������������������������������������������������������������������
						//� Verifica se e liberacao e verifica o saldo
						//����������������������������������������������������������������������������
						oGEN := CABREGIC():New()
						oGEN:GetDadReg(::o790C:cAIte,1, xFilial(::o790C:cAIte) + _Super:RetConCP(::o790C:cAIte,"NRLBOR") + _Super:RetConCP(::o790C:cAIte,"SEQUEN"),,,.F.)
		
						If oGEN:lFound
		
							If _Super:RetConCP(::o790C:cAIte,"SALDO",'N') == 0
								_Super:ExbMHelp( "O item n�o tem mais saldo para libera��o!" ) //"O item n�o tem mais saldo para libera��o!"
								lRet := .F.                                  
							EndIf	
							If oModelD:GetValue( 'B72_QTDAUT' ) > _Super:RetConCP(::o790C:cAIte,"SALDO",'N')
								_Super:ExbMHelp( "A quantidade n�o pode ser maior que o saldo restante!" ) //"A quantidade n�o pode ser maior que o saldo restante!"
								lRet := .F.                                  
							EndIf	
				        EndIf
				        oGEN:Destroy()
						//����������������������������������������������������������������������������
						//� Retorna ao registro original
						//����������������������������������������������������������������������������
					    ( ::o790C:cAIte )->( DbGoTo(nRecIte) )
					EndIf
				EndIf	
				
				
			EndIf	              
		EndIf
	EndIf
	//����������������������������������������������������������������������������
	//� Fim da Rotina															 
	//����������������������������������������������������������������������������
/*ELSE
	//����������������������������������������������������������������������������
	//� Verifica se foi Aprovado ou Rejeitado
	//����������������������������������������������������������������������������
	If oModelD:GetValue( 'B72_PARECE' ) $ '0,1,2'
		//����������������������������������������������������������������������������
		//� Verfica se o motivo foi informado
		//����������������������������������������������������������������������������
		If oModelD:GetValue( 'B72_PARECE' ) == '1' 
			If Empty( oModelD:GetValue("B72_MOTIVO") )
				MSGALERT( "Aten��o"+CRLF+"Informe no campo Motivo a raz�o do procedimento ser Negado!" ) //"Aten��o"###"Informe no campo Motivo a raz�o do procedimento ser Negado!"
				lRet := .F.
			EndIf
		Endif
		//*********************
		If oModelD:GetValue( 'B72_PARECE' ) == '2' 
			MSGALERT( "Aten��o"+CRLF+"Nenhum dado foi alterado. Se n�o deseja dar um parecer, utilize o bot�o Cancelar." ) //"Aten��o"###"Nenhum dado foi alterado. Se n�o deseja dar um parecer, utilize o bot�o Cancelar."
			lRet := .F.
		Endif			
	EndIf
ENDIF */ 	
If lRet .AND. !EMPTY(oModelD:GetValue('B72_OBSANA')) .AND. oModelD:GetValue('B72_PARECE') != "2"
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Optamos pela cria��o do ponto de entrada via execblock pois o model � chamado muitas vezes,
	//de forma que se utilizassemos o ponto de entrada do MVC o cliente teria que tratar para que executasse
	//sua fun��o apenas uma vez.                                
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	If ExistBlock("PLPADRCPA") 
		ExecBlock("PLPADRCPA",.F.,.F.,oModelD)
	Endif 
EndIf 
Return(lRet)                          
//-------------------------------------------------------------------
/*/ { Protheus.doc } VWInitVLD
Acao do botao ok da view

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD VWInitVLD( oView ) Class CABPADRC
LOCAL lRet := .T.            
//��������������������������������������������������������������������������Ŀ
//� Fim da Rotina															 �
//����������������������������������������������������������������������������
Return(lRet)
//-------------------------------------------------------------------
/*/ { Protheus.doc } VldRegOwner
Verifica se o operadora corrente e dono do registro selecionado no modelo

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD VldRegOwner(lAudITSA) Class CABPADRC
LOCAL lRet 	     := .T. 
DEFAULT lAudITSA := .F.
//��������������������������������������������������������������������������
//�Se o operador correte e dono do registro se lAudITSA TRUE chega o auditor
//�da interna-saude analisou um registro analisado.
//��������������������������������������������������������������������������
If !lAudITSA
	lRet := Empty(::cOwner) .Or. ::cOwner == ::cOperad
Else 
	lRet := Empty(::cOwnerAud) .Or. ::cOwnerAud == ::cOperad
EndIf	    
//��������������������������������������������������������������������������
//�Mensagem
//��������������������������������������������������������������������������
If !lRet
	_Super:ExbMHelp( "Somente o respons�vel pelo registro tem acesso") //"Somente o respons�vel pelo registro tem acesso"
EndIf
//��������������������������������������������������������������������������
//�Fim do Metodo
//��������������������������������������������������������������������������
Return(lRet)
//-------------------------------------------------------------------
/*/ { Protheus.doc } Destroy
Libera da memoria o obj (Destroy)

@author Alexander Santos
@since 02/02/11
@version 1.0
/*/
//-------------------------------------------------------------------
METHOD Destroy() Class CABPADRC
FreeObj(Self)
Return
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    �AtuPClass � Autor � Totvs				    	� Data � 30/03/10 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Atualiza propriedades da Classe	  						 			����
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Static Function AtuPClass(oSelf)
//����������������������������������������������������������������������������
//� Verifica qual modelo esta sendo usando pelo controle e atualiza propriedade da classe
//����������������������������������������������������������������������������
oSelf:cOperad 				:= RETCODUSR()
oSelf:lMDDemanda 			:= Iif(oSelf:cAlias=='B68',.T.,.F.)
oSelf:lEditaProcesso 		:= Iif(oSelf:cAlias=='B68' .And. B68->B68_PERPRC == '1',.T.,.F.)
oSelf:lIntSaudInco  		:= Iif(oSelf:cAlias=='B72' .And. B72->B72_INCONS $ '1,3',.T.,.F.)

oSelf:lMDNotacoes	 		:= Iif(oSelf:cAlias=='B69',.T.,.F.)
oSelf:lMDParticipativa 	:= Iif(oSelf:cAlias=='B70',.T.,.F.)
oSelf:lMDEncaminhamento	:= Iif(oSelf:cAlias=='B71',.T.,.F.)
oSelf:lMDAnaliseGui  		:= Iif(oSelf:cAlias=='B72',.T.,.F.)
oSelf:lMDRespAuditor  	:= Iif(oSelf:cAlias=='B73',.T.,.F.)
oSelf:cOwner  				:= Iif( (oSelf:cAlias)->( FieldPos(oSelf:cAlias + "_OPERAD") ) > 0,(oSelf:cAlias)->&( oSelf:cAlias + "_OPERAD" ),"")
oSelf:cOwnerAud			:= Iif( oSelf:cAlias=='B72',B72->B72_COPERE ,"")
oSelf:lOwnerEsp			:= oSelf:cOwner == oSelf:cOperad
//����������������������������������������������������������������������������
//� Atualiza informacoes da classe 790c
//����������������������������������������������������������������������������
oSelf:o790C:SetAtuPClass()
//����������������������������������������������������������������������������
//� Fim da Funcao
//����������������������������������������������������������������������������
Return


//-------------------------------------------------------------------
/*/ { Protheus.doc } VerIteAtB53
Verifica os status dos itens na tabela de Origem
Author Renan Martins
@since 04/2017
@version 1.0
/*/
//-------------------------------------------------------------------
//Static Function VeriteAtB53()
STATIC FUNCTION VeriteAtB53() 

Local o790C 		:= PLSA790C():New()
Local aAreaitem 	:= (o790C:cAite)->(GetArea())
Local aAreaCab  	:= (o790C:cAcab)->(GetArea())
Local nPosit		:= 0
Local nNegat		:= 0
Local lAut			:= .F.
(o790C:cAite)->(DbSetOrder((o790C:nIdxIte)))
(o790C:cAite)->(DbGoTop())

If ( !(o790C:cAcab) $ 'B4Q, BE4')
//Verifico se para esta guia ainda temos mais procedimentos em auditoriae se j� foram auditados
	If ( (o790C:cAite)->(MsSeek(xfilial(o790C:cAite)+Alltrim(B53->B53_NUMGUI))) )
		While ( !(o790C:cAite)->(EOF()) .AND. xFilial(o790C:cAite)+(o790C:cAite)->&(o790C:cAite+"_OPEMOV")+(o790C:cAite)->&(o790C:cAite+"_ANOAUT")+(o790C:cAite)->&(o790C:cAite+"_MESAUT")+(o790C:cAite)->&(o790C:cAite+"_NUMAUT")  == ;
		                                                                                 xFilial(o790C:cAite)+ Alltrim(B53->B53_NUMGUI))
	
			If (o790C:cAite)->&(o790C:cAite+"_STATUS") == '1'
				nPosit++
			Else
				nNegat++
			EndIf
				(o790C:cAite)->(dbSkip())
		EndDo
	EndIf
Else
	If ( (o790C:cAite)->(MsSeek(xfilial(o790C:cAite)+Alltrim(B53->B53_NUMGUI))) )
		While ( !(o790C:cAite)->(EOF()) .AND. xFilial(o790C:cAite)+(o790C:cAite)->&(o790C:cAite+"_CODOPE")+(o790C:cAite)->&(o790C:cAite+"_ANOINT")+(o790C:cAite)->&(o790C:cAite+"_MESINT")+(o790C:cAite)->&(o790C:cAite+"_NUMINT")  == ;
		                                                                                 xFilial(o790C:cAite)+ Alltrim(B53->B53_NUMGUI))

			If (o790C:cAite)->&(o790C:cAite+"_STATUS") == '1'
				nPosit++
			Else
				nNegat++
			EndIf
				(o790C:cAite)->(dbSkip())
		EndDo
	EndIf
EndIf

if nPosit == 0 
	lAut := .F.
Else
	lAut := .T.
EndIf

Return lAut


/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    �CABPADRC  � Autor � Totvs				    	� Data � 30/03/10 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Somente para compilar a class							  			����
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
User Function CABPADRC
Return
