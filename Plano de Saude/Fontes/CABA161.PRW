#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³                       ³ Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               ³±±
±±³              ³  /  /  ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function caba161()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cCmp       := Space(1)
Private cMensg    
Private cStCmp     := Space(1)
Private nQtdaProf  := 0
Private nQtdprod   := 0
Private nVlTotProc := 0

Private cAliastmp := GetNextAlias()
Private cAliasTot := GetNextAlias()
Private cAliasIw  := GetNextAlias()

Private cAliasCmp := GetNextAlias()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oGrp3","oSay1","oSay6","oSay7","oSay9","oSay22","oGet2","oGet3","oGet4","oGet6","oGrp10")
SetPrvt("oBtn11","oBtn12","oBtn22","oBtn23","oBtn24","oGet22","oGrp1","oMGet1")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

 
 fAchaComp1()

oDlg1      := MSDialog():New( 088,279,361,967,"Central de Rateios  ",,,.F.,,,,,,.T.,,,.T. )
oGrp3      := TGroup():New( 000,000,128,336,"Controle do Processo do IW",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 082,118,{||"Vlr Total Processado"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,051,008)
oSay6      := TSay():New( 010,118,{||"Compet. Em Proces."},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,050,008)
oSay7      := TSay():New( 034,118,{||"Status da Compet."},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,046,008)
oSay9      := TSay():New( 058,118,{||"Qtd De profissionais "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,049,008)
oSay22     := TSay():New( 107,118,{||"Total Procedimentos"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,054,008)
oGet2      := TGet():New( 018,118,{|u| If(PCount()>0,cCmp:=u,cCmp)},oGrp3,046,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmp",,)
oGet3      := TGet():New( 090,118,{|u| If(PCount()>0,nVlTotProc:=u,nVlTotProc)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlTotProc",,)
oGet4      := TGet():New( 042,118,{|u| If(PCount()>0,cStCmp:=u,cStCmp)},oGrp3,045,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cStCmp",,)
oGet6      := TGet():New( 066,118,{|u| If(PCount()>0,nQtdaProf:=u,nQtdaProf)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nQtdaProf",,)
oGrp10     := TGroup():New( 008,004,128,112,"Ações Possiveis ",oGrp3,CLR_HRED,CLR_WHITE,.T.,.F. )
oBtn10     := TButton():New( 015,009,"Manut. De -> Para (Iw-> Rda)",oGrp10,{||fCABA159()},099,016,,,,.T.,,"CABA159 - Manutenção da Relação do ProFisional Iw com Rda Caberj / Integral",,,,.F. )
oBtn11     := TButton():New( 051,009,"Manut. do Cadastro de  Remuneração ",oGrp10,{||fCABA160()},099,016,,,,.T.,,"CABA160 - Manutenção da Relmuneração ",,,,.F. )
oBtn12     := TButton():New( 089,009,"Cadastro de Movimento de pagamento",oGrp10,{||fCABA164()},099,016,,,,.T.,,"CABA164-Cadastro de Mivimento de pagamento",,,,.F. )
oBtn22     := TButton():New( 032,009,"Replica Cadastro de Remuneraçõa",oGrp10,{||fCABA162()},099,016,,,,.T.,,"CABA162-Replica Cadastro de Remuneraçõa / carga movimento Iw",,,,.F. )
oBtn23     := TButton():New( 070,009,"Gera Movimetos de Pag. / Rec. ",oGrp10,{||fCABA163()},099,016,,,,.T.,,"CABA163-Gera Movimetos de Pagamento / Recebimentos ",,,,.F. )
oBtn24     := TButton():New( 108,009,"Efetiva Lançamento de Deb/Cred ",oGrp10,{||fCABA165()},099,016,,,,.T.,,"CABA165 - Efetiva Lanc. Deb/Cred ",,,,.F. )
oGet22     := TGet():New( 115,118,{|u| If(PCount()>0,nQtdprod:=u,nQtdprod)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nQtdprod",,)
oGrp1      := TGroup():New( 008,176,128,336,"Mensagem do Sistema",oDlg1,CLR_HRED,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 016,180,{|u| If(PCount()>0,cMensg:=u,cMensg)},oGrp1,152,108,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )

 oDlg1:Activate(,,,.T.)


Return

Static Function fCaba165()
   
   cMensg:='Efetiva os Lançamentos de Pagamentos ao (Debitos) '
   cMensg+= CRLF +'e lançamentos de Recebimentos (creditos)'
   cMensg+= CRLF +'onde os debito na Caberj Iram Pagar ao RDAs'
   cMensg+= CRLF +',os debito na integral Iram resarci a Caberj'
   cMensg+= CRLF +' e os creditos na Caberj Iram Cobrar a Integral'
  
If ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")

  cMensg:= U_Caba165()    
  oMGet1:refresh()     
EndIf       

Return 

Static Function fCaba164()
   
   cMensg:='Visualização dos Lançamento de Pagamentos ao (Debitos) '
   cMensg+= CRLF +'e lançamentos de Recebimentos (creditos), '
   cMensg+= CRLF +'Gerados '

If ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")
  
   cMensg:= U_Caba164(cCmp)      
   oMGet1:refresh()  
  
EndIf        

Return 

Static Function fCaba163()
   
   cMensg:='Gera Lançamento de Pagamentos ao (Debitos) '
   cMensg+= CRLF +'e lançamentos de Recebimentos (creditos)'
   cMensg+= CRLF +'onde os debito na Caberj Iram Pagar ao RDAs'
   cMensg+= CRLF +',os debito na integral Iram resarci a Caberj'
   cMensg+= CRLF +' e os creditos na Caberj Iram Cobrar a Integral'

If ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")
  
   cMensg:=  U_Caba163()      
   oMGet1:refresh()

EndIf 
       
Return 

Static Function fCaba162()
   
   cMensg:='Replica o Cadastro de valores '
   cMensg+= CRLF +'de Pagamento Mensais e '
   cMensg+= CRLF +'Importa a movimentação IW '

If ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")
  
   cMensg:= U_Caba162()  
   
   fAchaComp1()    
   
   oMGet1:refresh()
   
EndIf 
       
Return 

Static Function fCaba160()
   
   cMensg:='Faz Manutenção Nos valores '
   cMensg+= CRLF +'de Pagamento Mensais '

If ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")
  
   U_Caba160(cCmp)       
   
   fAchaComp1()
   
   oMGet1:refresh()

EndIf
       
Return 

Static Function fCaba159()
   
   cMensg:='Faz Vinculação entre o profissional '
   cMensg+= CRLF +'cadastrado no Iw e o RDA de pagamento '+ CRLF + CRLF 

If ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")
  
   cMensg:= U_Caba159()      
   
   fAchaComp1()
   
   oMGet1:refresh()
  
EndIf     

Return ()

static Function fAchaComp1()                              

local cQuery  := ' ' 
local cQuery1 := ' ' 
local cQuery2 := ' ' 

cQuery := CRLF + "    SELECT MAX(PDJ_COMPTE) COMPTE " 
cQuery += CRLF + "      FROM "+ RetSqlName("PDJ") +" PDJ ," 
cQuery += CRLF + "           "+ RetSqlName("PDM") +" PDM " 
cQuery += CRLF + "     WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'" 
cQuery += CRLF + "       AND PDM_FILIAL = '" + xFilial("PDM") + "'" 
cQuery += CRLF + "       AND PDJ.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "       AND PDM.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "       AND PDM_COMPTE = PDJ_COMPTE " 
cQuery += CRLF + "       AND PDJ_QTDPRC > 0 "

If cempant == '01'

   cQuery += CRLF + "       AND PDM_CABINT = '1' AND PDM_FEITO = '1'"

Else 

   cQuery += CRLF + "       AND PDM_CABINT = '2' AND PDM_FEITO = '1'"

EndIf 
   
   If Select((cAliasCmp)) <> 0 
   
     (cAliasCmp)->(DbCloseArea())  
    
   Endif 
        
   TCQuery cQuery  New Alias (cAliasCmp)   

   (cAliasCmp)->(dbGoTop()) 
      
 If (cAliasCmp)->(!EOF()) .and. trim((cAliasCmp)->COMPTE) <> '0'  
 
     cano := val(substr((cAliasCmp)->COMPTE,1,4))
     cmes := val(substr((cAliasCmp)->COMPTE,5,2))
     
     If cmes < 12
        cmes++
     Else     
        cano++
        cmes:= 01
     EndIf 
     
     cCompte := strzero(cano,4)+strzero(cmes,2)
     
  //   cCompte :='201910'        
  
     cQuery1 := CRLF + "    SELECT nvl(count(*),0) qtda , nvl(sum(pdj_vlrcmp),0.00) VlrCmp " 
     cQuery1 += CRLF + "      FROM "+ RetSqlName("PDJ") +" PDJ " 
     cQuery1 += CRLF + "     WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'"   
     cQuery1 += CRLF + "       AND pdj_compte = '"+cCompte+"'"  

     If Select((cAliasTot)) <> 0 
   
        (cAliasTot)->(DbCloseArea())  
  
     Endif 
        
     TCQuery cQuery1  New Alias (cAliasTot)   

     (cAliasTot)->(dbGoTop()) 
      
      If (cAliasTot)->(!EOF()) .and. (cAliasTot)->qtda > 0
   
          cCmp       := cCompte
          cStCmp     := 'Em processamento'
          nQtdaProf  := (cAliasTot)->qtda
          nQtdprod   := fDadosIw(cCompte)
          nVlTotProc := allTrim(Transform((cAliasTot)->VlrCmp,'@E 999,999,999.99')) 
             
      Else  
      
       cQuery2 := CRLF + "    SELECT count(*)qtda , sum(pdj_vlrcmp)VlrCmp " 
       cQuery2 += CRLF + "      FROM "+ RetSqlName("PDJ") +" PDJ " 
       cQuery2 += CRLF + "     WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'"   
       cQuery2 += CRLF + "       AND pdj_compte = '"+trim((cAliasCmp)->COMPTE)+"'"  

       If Select((cAliasTot)) <> 0 
   
         (cAliasTot)->(DbCloseArea())  
  
       Endif 
        
       TCQuery cQuery2  New Alias (cAliasTot)   

      (cAliasTot)->(dbGoTop()) 
      
      If (cAliasTot)->(!EOF()) 
      
          cCmp       := trim((cAliasCmp)->COMPTE)
          cStCmp     := 'Processada'
          nQtdaProf  := (cAliasTot)->qtda
          nQtdprod   := fDadosIw(trim((cAliasCmp)->COMPTE))
          nVlTotProc := allTrim(Transform((cAliasTot)->VlrCmp,'@E 999,999,999.99'))
	            
      EndIf
    EndIf
   EndIf
     
     
return ()



 static function fDadosIw(cCompteIw)
   
 local cQuery   := " " 
 local nRet     := 0

cQuery := CRLF + " select count(*) qtda from moviw where compte ='"+cCompteIw+"'"
   
    If Select((cAliasIw)) <> 0 
   
         (cAliasIw)->(DbCloseArea())  
  
       Endif 
        
       TCQuery cQuery  New Alias (cAliasIw)   

      (cAliasIw)->(dbGoTop()) 
      
      If (cAliasIw)->(!EOF()) 
      
          nRet:= (cAliasIw)->qtda
      
      EndIf      
   
   return(nRet) 