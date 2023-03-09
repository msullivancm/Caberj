#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F70GRSE1  ºAutor  ³Microsiga           º Data ³  09/28/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada chamado no momento da baixa do SE1(quando  º±±
±±º          ³titulo nao eh o ultimo da sequencia)						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINANCEIRO                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function F70GRSE1() 
Local _cSQL := ""
Local aGerSeq1 := {}
Local aAreaSE1 := SE1->(GetArea())

If FunName() == "PLSA629"
	U_RemoveBSQ()	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Nos casos de parcelamento, incluir titulos provisorios cfme solicitado...³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	_cSQL := " SELECT BSQ_PREORI, BSQ_NUMORI, BSQ_PARORI, BSQ_TIPORI, BSQ_VALOR, BSQ_ZNATUR, BSQ_ZCLIEN, BSQ_ZLOJA, BSQ_CONEMP, BSQ_VERCON, BSQ_MES, BSQ_ANO, "
	_cSQL += " BSQ_SUBCON, BSQ_VERSUB, BSQ_ZEMISS, BSQ_ZEMIS1, BSQ_ZHIST, BSQ_ZVENCT, BSQ_ZVENRE, BSQ_ZJUROS, BSQ_CODINT, BSQ_CODEMP, BSQ_MATRIC , BSQ_PREFIX, BSQ_NUMTIT, BSQ_PARCEL, BSQ_TIPTIT "
	_cSQL += " FROM BSQ010 BSQ  "
	_cSQL += " WHERE BSQ_FILIAL = '"+xFilial("BSQ")+"' "
	_cSQL += " AND BSQ_CODINT = '"+SE1->E1_CODINT+"' "
	_cSQL += " AND BSQ_CODEMP = '"+SE1->E1_CODEMP+"' "
   //	If Alltrim(SE1->E1_MATRIC) <> Alltrim(SE1->E1_CONEMP)
	//	_cSQL += " AND BSQ_CONEMP = '"+SE1->E1_CONEMP+"' "
	//	_cSQL += " AND BSQ_VERCON = '"+SE1->E1_VERCON+"' "
	//	_cSQL += " AND BSQ_SUBCON = '"+SE1->E1_SUBCON+"' "
	//	_cSQL += " AND BSQ_VERSUB = '"+SE1->E1_VERSUB+"' "	
	//Else
		_cSQL += " AND BSQ_MATRIC = '"+SE1->E1_MATRIC+"' "	
	//Endif
	_cSQL += " AND BSQ_MES = '"+SE1->E1_MESBASE+"' "
	_cSQL += " AND BSQ_ANO = '"+SE1->E1_ANOBASE+"' "
	_cSQL += " AND BSQ_CODLAN = '991' "	
	_cSQL += " AND BSQ_PREORI <> ' ' "
	_cSQL += " AND BSQ_NUMORI <> ' ' "
	_cSQL += " AND BSQ_PARORI <> ' ' "
	_cSQL += " AND BSQ_TIPORI <> ' ' "
	_cSQL += " AND BSQ.D_E_L_E_T_ = ' ' "	
	PlsQuery(_cSQL,"TRB70GRSE1")	
	While !TRB70GRSE1->(Eof())		
		
		If ! SE1->(MsSeek(xFilial("SE1")+TRB70GRSE1->(BSQ_PREORI+BSQ_NUMORI+BSQ_PARORI+BSQ_TIPORI)))
			
			aGerSeq1 :={	{"E1_PREFIXO" ,TRB70GRSE1->BSQ_PREORI,Nil},;
						 	{"E1_NUM"     ,TRB70GRSE1->BSQ_NUMORI,Nil},;
	                    	{"E1_PARCELA" ,TRB70GRSE1->BSQ_PARORI,Nil},;
	                    	{"E1_TIPO"    ,TRB70GRSE1->BSQ_TIPORI,Nil},;
	                    	{"E1_VALOR"   ,TRB70GRSE1->BSQ_VALOR ,Nil},;
	                    	{"E1_CODINT"  ,TRB70GRSE1->BSQ_CODINT,Nil},;
	                    	{"E1_CODEMP"  ,TRB70GRSE1->BSQ_CODEMP,Nil},;
	                    	{"E1_CONEMP"  ,Iif(Empty(TRB70GRSE1->BSQ_MATRIC),TRB70GRSE1->BSQ_CONEMP,TRB70GRSE1->BSQ_MATRIC),Nil},; 
	                    	{"E1_VERCON"  ,TRB70GRSE1->BSQ_VERCON,Nil},;
	                    	{"E1_SUBCON"  ,TRB70GRSE1->BSQ_SUBCON,Nil},;
	                    	{"E1_VERSUB"  ,TRB70GRSE1->BSQ_VERSUB,Nil},;
	                    	{"E1_MATRIC"  ,TRB70GRSE1->BSQ_MATRIC,Nil},;
	                    	{"E1_NATUREZ" ,TRB70GRSE1->BSQ_ZNATUR,Nil},;
	                    	{"E1_CLIENTE" ,TRB70GRSE1->BSQ_ZCLIEN,Nil},;
	                    	{"E1_LOJA"    ,TRB70GRSE1->BSQ_ZLOJA ,Nil},;
	                    	{"E1_EMISSAO" ,TRB70GRSE1->BSQ_ZEMISS,Nil},;
	                    	{"E1_EMIS1"   ,TRB70GRSE1->BSQ_ZEMIS1,Nil},;
	                    	{"E1_HIST"    ,TRB70GRSE1->BSQ_ZHIST ,Nil},;
	                    	{"E1_VENCTO"  ,TRB70GRSE1->BSQ_ZVENCT,Nil},; 
	                    	{"E1_VENCREA" ,TRB70GRSE1->BSQ_ZVENRE,Nil},;	                    	
	                    	{"E1_MESBASE" ,TRB70GRSE1->BSQ_MES   ,Nil},;
	                    	{"E1_ANOBASE" ,TRB70GRSE1->BSQ_ANO   ,Nil},;	                    	
	                    	{"E1_PORCJUR" ,TRB70GRSE1->BSQ_ZJUROS,Nil} 	}                    			 
	                    	
			lMsErroAuto := .F.
			MsExecAuto({|x,y| Fina040(x,y)},aGerSeq1,3)
			If lMsErroAuto
				//DisarmTransaction()
				MostraErro()
			Endif
		Endif		
		
		TRB70GRSE1->(DbSkip())
		
	Enddo
	
	TRB70GRSE1->(DbCloseArea())
	
Endif

RestArea(aAreaSE1)

Return 