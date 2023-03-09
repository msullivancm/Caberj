#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "rwmake.ch"
#include "topconn.ch"
#Include "Colors.Ch"
#INCLUDE 'FONT.CH'

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL305ATM  ºMotta  ³Caberj              º Data ³      07/10  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ PE para criacao de Aba na tela de Atendimento Medico       º±±
±±º          ³ (marcacao Consulta/Agenda Medica) validando                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³ EM OUT/2014                                                º±±
±±º          ³    TROCADO O OBJETO DE EXIBICAO DE BROWSER PARA MEMO       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PL305ATM()
local aTit     := {}

local nFld     := 0
local bFld     := paramixb[1]
local aUsersFolders := {} //Matriz a ser inicializada com os folders a serem criados

local aArea    := GetArea()

local aBrowse1 :={}
local oBrowse1 := NIL
local aBrowse2 :={}
local oBrowse2 := NIL
local aBrowse3 :={}
local oBrowse3 := NIL 
local aBrowse4 :={}
local oBrowse4 := NIL


local oMemo2   := NIL 
local oMemo3   := NIL  
local oMemo4   := NIL 
local oMemo5   := NIL 
local oMemo6   := NIL 
local oMemo7   := NIL  

local cQuery   := " "
local cQstAnt  := " "  
local cSeqAnt  := " "   
local cMemo    := " "
/*
000908 carolina amorim		000810 luciana mota
000811 agatha rocha			000812 renata fraga
000813 renata correa		 
000830 juliana vigiani		000815 juliana anisio
000816 rosangela zicardi	000817 celia caldas
000818 karina manhaes		000819 thiara cruz
000831 thaisa araujo		000820 antonio oliveira
000821 aline lioi			000822 adva griner
000823 marina marques		000824 monica lessa
000825 proscila soares		000826 monique alves
000827 marcelo carlos       000828 cyntia klysse
000829 claudia trocado   	000832 Letícia Braz da Costa Maia
000804 João A Conceição	    000805 Elisabeth Ferreira Fernandes	 	       
000305 MOTTA(TESTES)        000668 Otavio (TESTES)
000678 Priscila             000250 Otaciano
*/
local cUUNATI  := GetNewPar("MV_YUNATI","000908,000810,000811,000812,000813,000830,000815,000816,000817,000818,000819,000831,000820,000821,000822,000823,"+;
                                        "000824,000825,000826,000827,000828,000829,000832,000804,000805,000305,000668,000678,000250") // acessos 
local lUnati   := .F.                       


//Local aBrowse7 :={}
local oTIBrowse8 := NIL
local aSize		 := MsAdvSize()        

private cMatVid  := BA1->BA1_MATVID

private  cQryO   := " "                        
private  cCodigo := " "             
private  cCodAte := " "
private  cCodPac := " "
private  cDesNom := " "     


lUnati := (__cUserID $ cUUNATI)

If lUnati
	aTit := {"Prescrição","Folha Rosto","Questionarios","Historico Exames"}
	// Matriz dos cabeçalhos dos folders   */
Else
	aTit := {"","Questionarios","Historico Exames"}
Endif


If bFld
	aUsersFolders := paramixb[2]
	For nFld := 1 To Len(aUsersFolders)
		If nFld == 1 // Historico Exames para Unati e !Unati
			aArea   :=GetArea()
			cSeqAnt := " "
			cQuery:="SELECT  BTH_CODATE , SUBSTR(FORMATA_DATA_MS(BTH_DATA),1,10) BTH_DATA, BR8_CODPAD  , BR8_CODPSA  ,  TRIM(BR8_DESCRI)  BR8_DESCRI,"
			cQuery+="        TRIM(OBTER_TEXTO_EXAME_BTI(BTI.R_E_C_N_O_)) BTI_LAUDO ,  BTI_QTD   "
			cQuery+="FROM   BTH010 BTH, BTI010 BTI, BR8010 BR8  "
			cQuery+="WHERE  BTH_FILIAL = '  '  "
			cQuery+="AND    BTH_CODPAC =  '" + M->BTH_CODPAC +  "'  "
			cQuery+="AND    BTH_CODATE <> '" + M->BTH_CODATE +  "'  "
			cQuery+="AND    BTI_FILIAL = BTH_FILIAL "
			cQuery+="AND    BTI_CODATE = BTH_CODATE  "
			cQuery+="AND    BR8_FILIAL = BTI_FILIAL  "
			cQuery+="AND    BR8_CODPAD = BTI_CODPAD  "
			cQuery+="AND    BR8_CODPSA = BTI_CODPRO  "
			cQuery+="AND    BTH.D_E_L_E_T_ = ' '  "
			cQuery+="AND    BTI.D_E_L_E_T_ = ' '  "
			cQuery+="AND    BR8.D_E_L_E_T_ = ' '  "
			cQuery+="ORDER BY BTI_YNGUIA , BR8_CODPAD  , BR8_CODPSA  "
			//
			TCQUERY cQuery ALIAS "QRY" NEW
			dbselectarea("QRY")
			QRY->(DbGoTop())
			while !(QRY->(eof()))
				aAdd(aBrowse1,{QRY->BTH_CODATE,QRY->BTH_DATA,QRY->BR8_CODPAD,QRY->BR8_CODPSA,QRY->BR8_DESCRI,QRY->BTI_LAUDO,QRY->BTI_QTD})
				dbselectarea("QRY")
				QRY->(dbskip())
			enddo// !(QRY->(eof()))
			dbclosearea()
			RestArea(aArea)
			If Len(aBrowse1) > 0
				oBrowse1 := TCBrowse():New( 01 , 01, 500, 225,,;   				
			    {'Atendimento','Data','Tabela','Codigo','Descricao','Laudo','Qtd.'},{35,35,10,40,100,100,15},;
				aUsersFolders[nFld],,,,,{||},,TFont():New('Courier new',,-8,.T.),,,,,.F.,,.T.,,.F.,,.T.,.T.)

				oBrowse1:SetArray(aBrowse1)

				oBrowse1:bLine := {||{aBrowse1[oBrowse1:nAt,01],;
                                      aBrowse1[oBrowse1:nAt,02],;
                                      aBrowse1[oBrowse1:nAt,03],;
                                      aBrowse1[oBrowse1:nAt,04],;
                                      aBrowse1[oBrowse1:nAt,05],;
                                      aBrowse1[oBrowse1:nAt,06],;
                                      aBrowse1[oBrowse1:nAt,07]} }
			Else
				@ 05,05 SAY "Historico de Exames não localizado ! " PIXEL OF aUsersFolders[nFld]
			Endif// Len(aBrowse1) > 0
		Endif// nFld == 1
		If nFld == 2 // Entrevista Inicial
			
				aArea   :=GetArea()
				cQstAnt := " "
				cSeqAnt := " "
				cQuery:="SELECT BAM.BAM_DESCRI, BXA.BXA_NUMERO, BXA.BXA_DATA, BXA_CODPRF, BB0_NOME, BB0_CODSIG, BB0_NUMCR, BB0_ESTADO, BAJ_CODPER, BAJ_DESCRI, " 
				cQuery+="BAK_CODRES, BAK_DESCRI, "
				cQuery+="       (CASE WHEN BAJ.BAJ_TIPRES = '2' THEN "
				cQuery+="              ((CASE WHEN BAK.BAK_CODRES = BXB.BXB_CODRES THEN ' (*)' ELSE ' ( )' END)) "
				cQuery+="             ELSE ' ' END) RESPOSTA, BXB_DESCOM "
				cQuery+="FROM   BXA010 BXA,BXB010 BXB,BA1010 BA1,BB0010 BB0,BAM010 BAM,BAJ010 BAJ,BAK010 BAK "
				cQuery+="WHERE  BXA.BXA_FILIAL = '  ' "
				cQuery+="AND    BXA.BXA_PROQUE = '2' "
			    cQuery+="AND    BXA.BXA_NUMERO = (SELECT MAX(BXA010.BXA_NUMERO) "
				cQuery+="                         FROM   BXA010 "
				cQuery+="                         WHERE  BXA_FILIAL = '  ' "
				cQuery+="                         AND    BXA_PROQUE = '2' " 
				/*trata os "pares" de questionarios trazendo o mais recente*/  
				cQuery+="AND    ((CASE WHEN BXA.BXA_CODQUE IN ('0002','0006') THEN 'AAG' "  
				cQuery+="              WHEN BXA.BXA_CODQUE IN ('0004','0005') THEN 'AVAAG' "  
				cQuery+="              WHEN BXA.BXA_CODQUE IN ('0013','0018') THEN 'SESO'  "  
				cQuery+="              WHEN BXA.BXA_CODQUE IN ('0012','0017') THEN 'ENFER' "  
				cQuery+="              WHEN BXA.BXA_CODQUE IN ('0011','0015') THEN 'NUTRI' "  
				cQuery+="              WHEN BXA.BXA_CODQUE IN ('0010','0016') THEN 'GER' "  
				cQuery+="              WHEN BXA.BXA_CODQUE IN ('0009','0014') THEN 'AFB'"  
				cQuery+="              WHEN BXA.BXA_CODQUE IN ('0008','0014') THEN 'PRISMA' "   
				cQuery+="              ELSE ' ' END) = (CASE WHEN BXA010.BXA_CODQUE IN ('0002','0006') THEN 'AAG' " 
				cQuery+="                                    WHEN BXA010.BXA_CODQUE IN ('0004','0005') THEN 'AVAAG' "   
				cQuery+="                                    WHEN BXA010.BXA_CODQUE IN ('0013','0018') THEN 'SESO' "   
				cQuery+="                                    WHEN BXA010.BXA_CODQUE IN ('0012','0017') THEN 'ENFER' "   
				cQuery+="                                    WHEN BXA010.BXA_CODQUE IN ('0011','0015') THEN 'NUTRI' " 
				cQuery+="                                    WHEN BXA010.BXA_CODQUE IN ('0010','0016') THEN 'GER' "   
				cQuery+="                                    WHEN BXA010.BXA_CODQUE IN ('0009','0014') THEN 'AFB' "
                cQuery+="                                    WHEN BXA010.BXA_CODQUE IN ('0008','0014') THEN 'PRISMA' "   
				cQuery+="                                    ELSE ' ' END)) "  
				cQuery+="                         AND    BXA_USUARI = '" + M->BTH_CODPAC + "' "
				cQuery+="                         AND    D_E_L_E_T_ = ' ') "
				cQuery+="AND    BXB.BXB_FILIAL = BXA.BXA_FILIAL "
				cQuery+="AND    BXB.BXB_NUMERO = BXA.BXA_NUMERO "
				cQuery+="AND    BA1.BA1_FILIAL = BXA.BXA_FILIAL "
				cQuery+="AND    BA1.BA1_CODINT = SubStr(BXA.BXA_USUARI,01,4) "
				cQuery+="AND    BA1.BA1_CODEMP = SubStr(BXA.BXA_USUARI,05,4) "
				cQuery+="AND    BA1.BA1_MATRIC = SubStr(BXA.BXA_USUARI,09,6) "
				cQuery+="AND    BA1.BA1_TIPREG = SubStr(BXA.BXA_USUARI,15,2) "
				cQuery+="AND    BA1.BA1_DIGITO = SubStr(BXA.BXA_USUARI,17,1) "
				cQuery+="AND    BB0.BB0_FILIAL (+) = BXA.BXA_FILIAL "
				cQuery+="AND    BB0.BB0_CODIGO (+) = BXA.BXA_CODPRF "
				cQuery+="AND    BAM.BAM_FILIAL = BXA.BXA_FILIAL "
				cQuery+="AND    BAM.BAM_PROPRI = BXA.BXA_PROQUE "
				cQuery+="AND    BAM.BAM_CODQUE = BXA.BXA_CODQUE "
				cQuery+="AND    BAJ.BAJ_FILIAL = BAK.BAK_FILIAL (+) "
				cQuery+="AND    BAJ.BAJ_PROQUE = BAK.BAK_PROQUE (+) "
				cQuery+="AND    BAJ.BAJ_CODQUE = BAK.BAK_CODQUE (+) "
				cQuery+="AND    BAJ.BAJ_CODPER = BAK.BAK_CODPER (+) "
				cQuery+="AND    BAJ.BAJ_FILIAL = BXA.BXA_FILIAL "
				cQuery+="AND    BAJ.BAJ_PROQUE = BXA.BXA_PROQUE "
				cQuery+="AND    BAJ.BAJ_CODQUE = BXA.BXA_CODQUE "
				cQuery+="AND    BAJ.BAJ_CODPER = BXB.BXB_CODPER "
				cQuery+="AND    BXA.D_E_L_E_T_ = ' ' "
				cQuery+="AND    BXB.D_E_L_E_T_ = ' ' "
				cQuery+="AND    BA1.D_E_L_E_T_ = ' ' "
				cQuery+="AND    Nvl(BB0.D_E_L_E_T_,' ') = ' ' "
				cQuery+="AND    BAM.D_E_L_E_T_ = ' ' "
				cQuery+="AND    BAJ.D_E_L_E_T_ = ' ' "
				cQuery+="AND    Nvl(BAK.D_E_L_E_T_,' ') = ' ' "
				cQuery+="ORDER BY BAM.BAM_DESCRI, "
				cQuery+="         BXA.BXA_NUMERO, "
				cQuery+="         BAJ_CODPER, "
				cQuery+="         BAK_CODPER, "
				cQuery+="         BAK_CODRES "
				//
				TCQUERY cQuery ALIAS "QRY" NEW
				dbselectarea("QRY")
				QRY->(DbGoTop())  
				while !(QRY->(eof()))       
				    If cQstAnt != QRY->BAM_DESCRI  
				      cMemo += QRY->BAM_DESCRI + CRLF 
				      cMemo += REPLICATE("=",LENGTH(ALLTRIM(QRY->BAM_DESCRI))) + CRLF  
				      cMemo += "Data " + SUBSTR(BXA_DATA,7,2) + "/" + SUBSTR(BXA_DATA,5,2) + "/" + SUBSTR(BXA_DATA,1,4)  
			          cQstAnt := QRY->BAM_DESCRI 
				    Endif
					If cSeqAnt != QRY->BAJ_CODPER    
						cMemo += '   ' + CRLF    
						cMemo += QRY->BAJ_CODPER + ' ' + QRY->BAJ_DESCRI + CRLF 
					Endif	
					//MOTTA OUT/14        
                    IF !(Empty(QRY->RESPOSTA))
				 		cMemo += '   ' + Trim(QRY->RESPOSTA) + ' ' + Trim(QRY->BAK_DESCRI) + ' ' + Trim(QRY->BXB_DESCOM) + CRLF  
				 	Else    
				 	  	cMemo += '   ' + Trim(QRY->BXB_DESCOM) + CRLF     
				 	Endif					
					dbselectarea("QRY") 
					cSeqAnt := QRY->BAJ_CODPER 
					QRY->(dbskip())
				enddo// !(QRY->(eof()))
				dbclosearea()
				RestArea(aArea)
				If Len(cMemo) > 0
					// motta out/14     
				   oMemo2 := tMultiGet():New(05,05,{||" "},aUsersFolders[nFld],500,800,,,,,,.T.,,.T.,,,,.T.)
				   oMemo2:AppendText(cMemo)
				Else
					@ 05,05 SAY "QUESTIONARIOS - NAO LOCALIZADO " PIXEL OF aUsersFolders[nFld]
				Endif// Len(aBrowse2) > 0
				
		Endif// nFld == 2 
				
		If nFld == 3 // folha rosto   
		
			//DEFINE DIALOG oDlg TITLE "Painel" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL   
	
			oTIBrowse8 := TIBrowser():New(aSize[7]/2,0, aSize[6],aSize[5]/4.5, 'http://relatorios.caberj.com.br/Cac/FolhaRosto.asp?vMatric='+M->BTH_CODPAC,aUsersFolders[nFld] )//ajuste no posicionamento
		    
		    TButton():New( aSize[7],0, "Imprimir", aUsersFolders[nFld],;
		     {|| oTIBrowse8:Print() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )
		          
		    //ACTIVATE DIALOG oDlg CENTERED 		   
		    
		endif		 
        
        /*---------------------------------------------------------------
        | PRESCRICAO - Customizado em 05/02/2015 - OSP Otavio            |
         ---------------------------------------------------------------*/
         
		If nFld == 4 // Prescrição       
           aArea   := GetArea()           
           cSeqAnt := " "
           cDesNom := ""
           
           dbSelectArea("ZRD") ; ZRD->( dbSetOrder(1) )

           cQuery  := "SELECT ZRD_CODATE "
           cQuery  += "     , ZRD_CODPRO "
           cQuery  += "     , (SELECT B1_DESC " 
           cQuery  += "        FROM SB1010 B1 "
           cQuery  += "        WHERE B1.D_E_L_E_T_ = ' ' "
           cQuery  += "          AND B1_COD        = ZRD_CODPRO ) B1_DESC "
           cQuery  += "     , (SELECT BTH_CODPAC "
           cQuery  += "        FROM BTH010 BTH "
           cQuery  += "        WHERE BTH.D_E_L_E_T_ = ' ' "
           cQuery  += "          AND BTH_FILIAL     = ' ' "
           cQuery  += "          AND BTH_CODATE     = ZRD_CODATE ) BTH_CODPAC "
           cQuery  += "     , (SELECT BTH_NOMPAC "
           cQuery  += "        FROM BTH010 BTH "
           cQuery  += "        WHERE BTH.D_E_L_E_T_ = ' ' "
           cQuery  += "          AND BTH_FILIAL     = ' ' "
           cQuery  += "          AND BTH_CODATE     = ZRD_CODATE ) BTH_NOMPAC "
           cQuery  += "     , ZRD_QTDSOL "
           cQuery  += "     , ZRD_POSOL "
           cQuery  += "     , ZRD_QTDPOS "
           cQuery  += "     , ZRD_UNIPOS "
           cQuery  += "     , ZRD_ARMAZ "           
           cQuery  += "FROM   ZRD010 ZRD "
           cQuery  += "WHERE  ZRD_FILIAL     = '  ' "
           cQuery  += "  AND  ZRD_CODATE IN (SELECT BTH_CODATE "
           cQuery  += "                      FROM BTH010 BTHz "
           cQuery  += "                      WHERE BTHz.D_E_L_E_T_ = ' ' "
           cQuery  += "                        AND BTH_FILIAL     = ' ' "
           cQuery  += "                        AND BTH_MATVID = '"+cMatVid+"' ) "
	       cQuery  += "  AND  ZRD.D_E_L_E_T_ = ' ' " 
           cQuery  += "ORDER BY ZRD_CODATE , ZRD_CODPRO"
           TCQUERY cQuery ALIAS "QRY" NEW
			
           dbSelectArea("QRY")
		   QRY->( dbGoTop() )
            
		   while QRY->( !EOF() )
			  aAdd(aBrowse4,{QRY->ZRD_CODATE,QRY->ZRD_CODPRO,QRY->B1_DESC,QRY->BTH_CODPAC,QRY->BTH_NOMPAC,QRY->ZRD_QTDSOL,QRY->ZRD_POSOL,QRY->ZRD_QTDPOS,QRY->ZRD_UNIPOS,QRY->ZRD_ARMAZ})
		      QRY->( dbskip() )
		   enddo

           cCodAte := "" 
   
           if Len(aBrowse4) = 0             

              //---------------------------------------------------------- BUSCA O CODIGO DE ATENDIMENTO
              cQryO   := " "                        

              cCodigo := " "             
              cCodAte := " "             
              cCodPac := " "
              cDesNom := " "
              
              cQryO := "SELECT BAU_CODIGO FROM "+RetSQLName("BAU")+" WHERE D_E_L_E_T_ = ' ' AND  BAU_CODCFG = '"+RetCodUsr()+"'"

              TcQuery cQryO New Alias "TMPX"
              dbSelectArea("TMPX")
              TMPX->( dbGoTop() )
              if TMPX->( !Eof() ) 
                 cCodigo := TMPX->BAU_CODIGO
              end

              TMPX->( dbCloseArea() )
              
              cQryO := " SELECT MAX(BBD_NUMATE) BBD_NUMATE, BBD_CODPAC, BBD_NOME "
              cQryO += " FROM "+RetSqlName("BBD")+" "
              cQryO += " WHERE  BBD_FILIAL = '  ' "
              cQryO += " AND    BBD_CODIGO = '"+cCodigo+"' "   
              cQryO += " AND    BBD_MATVID = '"+cMatVid+"' "   
              cQryO += " AND    D_E_L_E_T_ = ' ' "
              cQryO += " GROUP BY BBD_NUMATE, BBD_CODPAC, BBD_NOME "
              TcQuery cQryO New Alias "TMPX"
              dbSelectArea("TMPX")
              TMPX->( dbGoTop() )
              if TMPX->( !Eof() ) 
                 cCodAte := TMPX->BBD_NUMATE 
                 cCodPac := TMPX->BBD_CODPAC
                 cDesNom := TMPX->BBD_NOME
              end
              TMPX->( dbCloseArea() )
              
              //-----------------------------------------------------------

              aAdd(aBrowse4,{cCodAte,space(12),space(70),cCodPac,cDesNom,0,0,0," "," "})              
              
           else
              xAreaAnt := BTH->( GetArea() )           
              BTH->( dbSetorder(4) )
              if BTH->( dbSeek(xFilial("BTH")+cMatVid) )
                 while BTH->( BTH_FILIAL == ' ' .AND. BTH_MATVID == cMatVid .AND. !EOF() )
                    cCodAte := BTH->BTH_CODATE 
                    BTH->( dbSkip() )
                 end     
              endif
              RestArea(xAreaAnt)           
           endif
            
            oBrowse4 := TCBrowse():New( 01 , 01, 550, 225,,; 
                                       {'Atendimento','Produto','Descrição','Matricula','Nome','QTDSOL','POSOL','QTDPOS','UNIPOS','ARMAZ'},{15,20,100,17,100,4,2,2,1,2},;
                                       aUsersFolders[nFld],,,,,{||aBrowse4[oBrowse4:nAt,1] := !aBrowse4[oBrowse4:nAt,1], oBrowse4:Refresh()},,,,,,,.F.,"QRY",.T.,,.F.,,, )    //,,,,,,,.F.,,.T.,,.F.,,.T.,.T.)
                      
           oBrowse4:SetArray(aBrowse4)

           oBrowse4:bLDblClick   := {|| TelaMed(aBrowse4[oBrowse4:nAt,01],;
                                                aBrowse4[oBrowse4:nAt,02],;
                                                aBrowse4[oBrowse4:nAt,03],;
                                                aBrowse4[oBrowse4:nAt,04],;
                                                aBrowse4[oBrowse4:nAt,05],;
                                                aBrowse4[oBrowse4:nAt,06],;
                                                aBrowse4[oBrowse4:nAt,07],;
                                                aBrowse4[oBrowse4:nAt,08],;
                                                aBrowse4[oBrowse4:nAt,09],; 
                                                aBrowse4[oBrowse4:nAt,10])} //alert('Criar a janela de dados (ZRD) neste ponto'+CHR(13)+CHR(13)+'*** Em Desenvolvimento ***') }                                                

           oBrowse4:bLine := {||{aBrowse4[oBrowse4:nAt,01],;
                                 aBrowse4[oBrowse4:nAt,02],;
                                 aBrowse4[oBrowse4:nAt,03],;
                                 aBrowse4[oBrowse4:nAt,04],;
                                 aBrowse4[oBrowse4:nAt,05],;
                                 aBrowse4[oBrowse4:nAt,06],;
                                 aBrowse4[oBrowse4:nAt,07],;
                                 aBrowse4[oBrowse4:nAt,08],;
                                 aBrowse4[oBrowse4:nAt,09],; 
                                 aBrowse4[oBrowse4:nAt,10]} }                                  
           oBrowse4:Refresh()
                       
           QRY->( dbCloseArea() )                         
            
           RestArea(aArea)
        endif
	Next nFld
   return
else
   return aTit
endIf
return



/*------------------------------------------------------------------------
| Funcao    | TelaMed  | Otavio Pinto                  | Data | 09/02/15  |
|-------------------------------------------------------------------------|
| Descricao | Tela para inclusão/Alteração na tabela ZRD                  |
|-------------------------------------------------------------------------|
| Uso       |                                                             |
|           |                                                             |
 ------------------------------------------------------------------------*/
static function TelaMed(cGet1,cGet2,cGet3,cGet4,cGet5,nGet6,nGet7,nGet8,cGet9,cGet0)
local nTipo := 1

/*------------------------------------------------------------------------
| Declaração de Variaveis Private dos Objetos                             |
 ------------------------------------------------------------------------*/
SetPrvt("oDlg1","oPanel1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oSay7","oSay8","oSay9")
SetPrvt("oGet1","oGet2","oGet3","oGet4","oGet5","oGet6","oGet7","oBtn1","oBtn2")

private xGet1 := space(12)
private xGet2 := space(15)

/*------------------------------------------------------------------------
| Definicao do Dialog e todos os seus componentes.                        |
 ------------------------------------------------------------------------*/
oFont18AP  := TFont():New( "Arial Black",0,-14,,.T.,0,,700,.F.,.F.,,,,,, )
 
oDlg1      := MSDialog():New( 088,232,462,850,"MEDICAMENTOS X ATENDIMENTO",,,.F.,,,,,,.T.,,,.T. )
oPanel1    := TPanel():New( 016,008,"",oDlg1,,.F.,.F.,,,288,152,.T.,.F. )

if Empty(cCodPac) 
   cGet4      := POSICIONE("BTH",1,xFilial("BTH")+cGet1,"BTH_CODPAC")
   cget5      := POSICIONE("BTH",1,xFilial("BTH")+cGet1,"BTH_NOMPAC") 
endif   

oSay1      := TSay():New( 031,012,{||"Atendimento"   },oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_CYAN,039,008)
oSay2      := TSay():New( 047,012,{||"Medicamento"   },oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay3      := TSay():New( 047,116,{||cGet3           },oPanel1,,oFont18AP,.F.,.F.,.F.,.T.,CLR_BLUE ,CLR_CYAN,152,008)
oSay4      := TSay():New( 064,012,{||"Matricula"     },oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_CYAN,040,008)
oSay5      := TSay():New( 064,118,{||cGet5           },oPanel1,,oFont18AP,.F.,.F.,.F.,.T.,CLR_BLUE ,CLR_CYAN,167,008)
oSay6      := TSay():New( 081,012,{||"Qtd.Solicitada"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,007)
oSay7      := TSay():New( 097,013,{||"Posologia"     },oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
oSay8      := TSay():New( 098,077,{||"Qtd.Posologia" },oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
oSay9      := TSay():New( 098,141,{||"Unid.Posologia"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)

xGet1      := cGet1
xGet2      := cGet2
          
oGet1      := TGet():New( 030,052,{|u| if(PCount()>0,cGet1:=u,cGet1)},oPanel1,060,008,'@ 999999999999',,CLR_BLACK,CLR_CYAN,,,,.T.,,,,,,,.T.,,,'cGet1')
oGet2      := TGet():New( 046,052,{|u| if(PCount()>0,cGet2:=u,cGet2)},oPanel1,060,008,'@ 999999999999999',{|o|cGet3 := POSICIONE("SB1",1,xFilial("SB1")+cGet2,"B1_DESC")},,,,,,.T.,,,,,,,,,"PLSB1M",'cGet2')
oGet3      := TGet():New( 063,052,{|u| if(PCount()>0,cGet4:=u,cGet4)},oPanel1,065,008,'@R !!!!.!!!!.!!!!!!-!!-!',,CLR_BLACK,CLR_CYAN,,,,.T.,,,,,,,.T.,,,'cGet4')
oGet4      := TGet():New( 080,053,{|u| if(PCount()>0,nGet6:=u,nGet6)},oPanel1,060,008,'9999', {|| u_VldEstMed(cGet2,cGet1,nGet6) } ,,,,,,.T.,,,,,,,,,,'nGet6')
oGet5      := TGet():New( 104,013,{|u| if(PCount()>0,nGet7:=u,nGet7)},oPanel1,055,008,'99',,,,,,,.T.,,,,,,,,,        ,'nGet7')
oGet6      := TGet():New( 105,077,{|u| if(PCount()>0,nGet8:=u,nGet8)},oPanel1,055,008,'99',,,,,,,.T.,,,,,,,,,        ,'nGet8')
oGet7      := TGet():New( 105,141,{|u| if(PCount()>0,cGet9:=u,cGet9)},oPanel1,055,008,'9' ,,,,,,,.T.,,,,,,,,,"SX5ZP" ,'cGet9')

oBtn1      := TButton():New( 132,180,"Ok",oPanel1,{|| PL305001(cGet1,cGet2,cGet3,cGet4,cGet5,nGet6,nGet7,nGet8,cGet9),;
                                                               oDlg1:End() },037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 132,240,"Cancela",oPanel1,{|| oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.)

return .T.


/*------------------------------------------------------------------------
| Funcao    | PL305001 | Otavio Pinto                  | Data | 06/02/15  |
|-------------------------------------------------------------------------|
| Descricao | Salva/compoe campos de memoria conforme o folder utilizado. |
|-------------------------------------------------------------------------|
| Uso       |                                                             |
|           |                                                             |
 ------------------------------------------------------------------------*/
static function PL305001(cGet1,cGet2,cGet3,cGet4,cGet5,nGet6,nGet7,nGet8,cGet9)
nTIPO := if( ZRD->( !dbSeek(xFilial("ZRD")+cGet1+cGet2) ), 1, 2 )

RecLock ("ZRD", if(nTIPO == 1,.T.,.F.) )
ZRD->ZRD_FILIAL := ""
ZRD->ZRD_CODATE := cGet1
ZRD->ZRD_CODPRO := cGet2
ZRD->ZRD_QTDSOL := nGet6
ZRD->ZRD_POSOL  := nGet7
ZRD->ZRD_QTDPOS := nGet8
ZRD->ZRD_UNIPOS := cGet9
ZRD->ZRD_ARMAZ  := u_fCodAge( cGet1 )
ZRD->( MsUnlock() )

return (.T.)


/*-------------------------------------------------------------------------- 
| Funcao | VldEstMed     | Autor | Paulo Motta           | Data | 27/01/2015|
|---------------------------------------------------------------------------|
| Descricao: Critica posição ndo estoque.                                   |
|                                                                           |
 --------------------------------------------------------------------------*/
user function VldEstMed(cCodpro,cCodAte,nQtd)    
local cMsg    := " "    
local dDatAte := dDataBase 
local cLocal  := u_fCodAge( cCodAte )  //"01"  //"56"      
local _sAlias := Alias()


//Pega a data na tabela de Atendimentos Consultas
dbSelectArea("BTH") ; BTH->( dbSetOrder(1) )
if BTH->( dbSeek(xFilial("BTH")+cCodAte) )
   dDatAte := BTH->BTH_DATA
endIf 
dbCloseArea("BTH") 

//Pega o armazem na tabela de Consultas Médicas
dbSelectArea("BBD") ; BBD->( dbSetOrder(8) )
if dbSeek(xFilial("BBD")+DTOS(dDatAte)+cCodAte)
   cLocal := Substr(BBD->BBD_CODLOC,2,2)
endIf 
dbCloseArea("BBD")  

//cLocal := if ( cLocal $ "56,57" , "57" , cLocal ) // Precisa ser pensado numa definição para o caso da Tijuca...

//teste armazem local
dbSelectArea("SB2") ; SB2->( dbSetOrder(1) )
if dbSeek(xFilial("SB2")+cCodPro+cLocal)
   if SB2->B2_QATU < nQtd  // if SB2->B2_QFIM < nQtd 
      cMsg := "Quantidade indisponivel no Estoque Local"     
   endif  		
endIf 
dbCloseArea("SB2") 

//teste armazem geral(01)
dbSelectArea("SB2") ; SB2->( dbSetOrder(1) )
if dbSeek(xFilial("SB2")+cCodPro+"01")
   if SB2->B2_QATU < nQtd  //if SB2->B2_QFIM < nQtd 
      cMsg += if( !empty( cMsg ), " \ ", "" )
      cMsg += "Quantidade indisponivel no Estoque Central"
   endif  		
endIf 
dbCloseArea("SB2")

if !Empty( cMsg ) ; Alert( cMsg ) ; endif  

dbSelectArea(_sAlias)

return .t.


// Fim da rotina PL305ATM.PRW