#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#include "topconn.ch"
#INCLUDE "TOTVS.CH"

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

User Function caba126(cAlias,nReg,nOpc) 


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

Private cClsRed    := Space(1)
Private cCompt     := Space(1)
Private cCptcus    := Space(1)
Private cDescItPg  := Space(1)
Private cdia       := Space(1)
Private cPercDistA := 0.00
Private cSeq       := ' '
Private cSldDristA := 0.00
Private cVlrDistB  := 0.00
Private cVLREC     := 0.00
Private cVlrLib    := 0.00
Private cVlrpgto   := 0.00   
Private cVlrLib    := 0.00
Private cVlrNLib   := 0.00
Private cVlrpgto   := 0.00
Private cqtdPrcpgt := ' '
Private dDtCalen   := CtoD(" ")
Private dDtpgto    := CtoD(" ")
Private nPercRec   := 0.00
Private nStatus   
Private nVlrLim    := 0.00   
private cqtdatot   := 0.00      

Private cVlCmpAnt1 := 0.00
Private cVlCmpAnt2 := 0.00
Private cVlCmpAnt3 := 0.00
Private cVlCmpAtu  := 0.00         
Private cCmpAnt1   := Space(1)
Private cCmpAnt2   := Space(1)
Private cCmpAnt3   := Space(1)
Private cCmpAtu    := Space(1)


Private dDtatu     := dtos(dDataBase - 10)
private cAliasqPer := GetNextAlias()             
private cAliasqRes := GetNextAlias()    
private cAliasqRes1:= GetNextAlias() 
private cAliasqSe2 := GetNextAlias()


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

/*
SetPrvt("oDlg1","oGrp1","oSay2","oSay6","oSay11","oSay46","oSay17","oSay1","oSay3","oSay4","oSay5","oSay7")
SetPrvt("oSay14","oSay15","oSay16","oGet2","oGet6","oGrp5","oBtn13","oBtn8","oBtn7","oCBox2","oGet39")
SetPrvt("oGet1","oGet3","oGet4","oGet5","oGet7","oGet8","oGrp2","oSay9","oSay10","oSay12","oSay13","oGet9")
SetPrvt("oGet11","oGet12","oGet13","oGet14","oGet15")
*/

SetPrvt("oDlg1","oSay20","oGrp1","oSay2","oSay6","oSay11","oSay46","oSay17","oSay1","oSay3","oSay4","oSay5")
SetPrvt("oSay8","oSay14","oSay15","oSay16","oGet2","oGet6","oGrp5","oBtn13","oBtn8","oBtn7","oCBox2")
SetPrvt("oGet17","oGet1","oGet3","oGet4","oGet5","oGet7","oGet8","oGrp2","oSay9","oSay10","oSay12","oSay13")
SetPrvt("oGet10","oGet11","oGet12","oGet13","oGet14","oGet15","oGrp3","oSay18","oSay19","oSay21","oSay22")
SetPrvt("oSay24","oSay25","oSay26","oGet16","oGet18","oGet20","oGet21","oGet22","oGet23","oGet24","oGet25")



If nopc == 3 
   cNumCab:=fProxNum() 
else                                                                       
   	 dbselectarea("PCQ")
     DbGoto(nReg)
     fMovArqVar()
EndIf     
        
fCalcres(cCptcus,str(cSeq)  )

cqtdPrcpgt:= trim(str(cqtdatot))+" / "+ ltrim(str((cAliasqRes1)->qtda))      

fcalSe2(cCptcus ,  cClsRed , substr(cDescItPg,1,4) )            

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/       

oDlg1      := MSDialog():New( 255,356,532,1084,"Parametros de Pagamento ",,,.F.,,,,,,.T.,,,.T. )
//oDlg1      := MSDialog():New( 165,338,361,1066,"Parametros de Pagamento ",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,092,356,"Manutenção dos Parametros",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay2      := TSay():New( 028,004,{||"Descrição Item Pagto   "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,064,008)
oSay6      := TSay():New( 048,039,{||"% da Receita   "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay11     := TSay():New( 007,140,{||"Status"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay46     := TSay():New( 048,004,{||"Clas. Rede"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay17     := TSay():New( 048,080,{||"Ate o Valor Limite "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay1      := TSay():New( 048,136,{||"Dia Lib "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay3      := TSay():New( 007,004,{||"Competencia"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay4      := TSay():New( 007,040,{||"Sequencia"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay5      := TSay():New( 007,076,{||"Vlr Receita"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay7      := TSay():New( 048,172,{||"Calendario Pgto "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay8      := TSay():New( 068,173,{||"Data  Pgto "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,035,008)
oSay14     := TSay():New( 068,004,{||"Vlr Liberado "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay15     := TSay():New( 068,057,{||"Vlr Pago "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay16     := TSay():New( 068,114,{||"Vlr Hà Lib"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet2      := TGet():New( 036,004,{|u| If(PCount()>0,cDescItPg:=u,cDescItPg)},oGrp1,208,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cDescItPg",,)
oGet6      := TGet():New( 056,040,{|u| If(PCount()>0,nPercRec:=u,nPercRec)},oGrp1,028,008,'@E 99.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercRec",,)
oGet6:bLostFocus:={|| fCalcVal(nPercRec, cVLREC ) }
oGrp5      := TGroup():New( 004,288,088,352,"Menu ",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn13     := TButton():New( 068,300,"Sair",oGrp5,{||oDlg1:End()},044,012,,,,.T.,,"",,,,.F. )
oBtn8      := TButton():New( 044,300,"Deleta",oGrp5,{||fDeletaArq()},044,012,,,,.T.,,"",,,,.F. )
oBtn7      := TButton():New( 016,300,"Grava",oGrp5,{||fMovVarArq() },044,012,,,,.T.,,"",,,,.F. )
oCBox2     := TComboBox():New( 016,140,{|u| If(PCount()>0,nStatus:=u,nStatus)},{"Ativo","Concluido","Suspenso ","Cancelado"},072,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nStatus )
oGet39     := TGet():New( 056,004,{|u| If(PCount()>0,cClsRed:=u,cClsRed)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cClsRed",,)
oGet17     := TGet():New( 056,080,{|u| If(PCount()>0,nVlrLim:=u,nVlrLim)},oGrp1,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrLim",,)
oGet17:bLostFocus:={|| fCalcperc(nVlrLim, cVLREC ) }  
oGet1      := TGet():New( 056,136,{|u| If(PCount()>0,cdia:=u,cdia)},oGrp1,020,008,'@E 99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cdia",,)
oGet3      := TGet():New( 016,004,{|u| If(PCount()>0,cCptcus:=u,cCptcus)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptcus",,)
oGet4      := TGet():New( 016,040,{|u| If(PCount()>0,cSeq:=u,cSeq)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSeq",,)
oGet5      := TGet():New( 016,076,{|u| If(PCount()>0,cVLREC:=u,cVLREC)},oGrp1,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVLREC",,)
oGet7      := TGet():New( 056,172,{|u| If(PCount()>0,dDtCalen:=u,dDtCalen)},oGrp1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtCalen",,)
oGet8      := TGet():New( 076,172,{|u| If(PCount()>0,dDtpgto:=u,dDtpgto)},oGrp1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtpgto",,)
oGrp2      := TGroup():New( 004,216,088,284,"Resumo da Competencia",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay9      := TSay():New( 011,220,{||"Qtda Processada/Total"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
oSay10     := TSay():New( 027,221,{||"Saldo A Distribuir."},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,055,008)
oSay12     := TSay():New( 045,221,{||"Valor Distribuido"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay13     := TSay():New( 066,221,{||"Percentual Distribuido "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oGet9      := TGet():New( 017,224,{|u| If(PCount()>0,cqtdPrcpgt:=u,cqtdPrcpgt)},oGrp2,056,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdPrcpgt",,)
oGet10     := TGet():New( 034,225,{|u| If(PCount()>0,cSldDristA:=u,cSldDristA)},oGrp2,055,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSldDristA",,)
oGet11     := TGet():New( 054,225,{|u| If(PCount()>0,cVlrDistB:=u,cVlrDistB)},oGrp2,055,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVlrDistB",,)
oGet12     := TGet():New( 074,225,{|u| If(PCount()>0,cPercDistA:=u,cPercDistA)},oGrp2,055,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cPercDistA",,)
oGet13     := TGet():New( 076,004,{|u| If(PCount()>0,cVlrLib:=u,cVlrLib)},oGrp1,044,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVlrLib",,)
oGet14     := TGet():New( 076,057,{|u| If(PCount()>0,cVlrpgto:=u,cVlrpgto)},oGrp1,052,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVlrpgto",,)
oGet15     := TGet():New( 076,114,{|u| If(PCount()>0,cVlrNLib:=u,cVlrNLib)},oGrp1,052,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVlrNLib",,)

oGrp3      := TGroup():New( 093,000,129,356,"Distribuição de Valores por Competencia ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay18     := TSay():New( 102,004,{||"Comp. Atual "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay19     := TSay():New( 102,042,{||"Vlr Comp. Atual "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay21     := TSay():New( 102,093,{||"Comp. Ant. 1"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay22     := TSay():New( 102,131,{||"Vlr Comp. Ant 1 "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay23     := TSay():New( 102,182,{||"Comp. Ant 2 "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,030,008)
oSay24     := TSay():New( 102,216,{||"Vlr Comp. Ant 2 "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay25     := TSay():New( 102,301,{||"Vlr Comp. Ant 3 "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay26     := TSay():New( 102,267,{||"Comp. Ant 3 "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oGet16     := TGet():New( 115,004,{|u| If(PCount()>0,cCmpAtu:=u,cCmpAtu)},oGrp3,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpAtu",,)
oGet18     := TGet():New( 115,041,{|u| If(PCount()>0,cVlCmpAtu:=u,cVlCmpAtu)},oGrp3,044,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cVlCmpAtu",,)
oGet20     := TGet():New( 115,093,{|u| If(PCount()>0,cCmpAnt1:=u,cCmpAnt1)},oGrp3,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpAnt1",,)
oGet21     := TGet():New( 115,130,{|u| If(PCount()>0,cVlCmpAnt1:=u,cVlCmpAnt1)},oGrp3,044,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cVlCmpAnt1",,)
oGet22     := TGet():New( 115,181,{|u| If(PCount()>0,cCmpAnt2:=u,cCmpAnt2)},oGrp3,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpAnt2",,)
oGet23     := TGet():New( 115,214,{|u| If(PCount()>0,cVlCmpAnt2:=u,cVlCmpAnt2)},oGrp3,044,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cVlCmpAnt2",,)
oGet24     := TGet():New( 115,303,{|u| If(PCount()>0,cVlCmpAnt3:=u,cVlCmpAnt3)},oGrp3,044,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cVlCmpAnt3",,)
oGet25     := TGet():New( 115,266,{|u| If(PCount()>0,cCmpAnt3:=u,cCmpAnt3)},oGrp3,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpAnt3",,)


oDlg1:Activate(,,,.T.)  
            
Return
  
Static function fCalcres(cCompt, cseq)   

	cQryqRes := CRLF +" SELECT  count(*) qtda , SUM(PCQ_PERCU) TotPerc , sum(pcq_vlrli) TotLib ,  (pcq_vlrec-(sum(pcq_vlrli))) SALDO "
	cQryqRes += CRLF +"	  FROM " +RetSqlName('PCQ')+ " PCQ  "  
	cQryqRes += CRLF +"  WHERE PCQ_FILIAL = '"+xFilial('PCQ')+"' "
	cQryqRes += CRLF +"    AND PCQ.d_E_L_E_T_ = ' ' "
	cQryqRes += CRLF +"    AND PCQ_CPTPGT = '"+cCompt+"' " 
    cQryqRes += CRLF +"    AND trim(PCQ_STATU) in('Ativo','Concluido') and PCQ_SEQ = '"+cseq+"' "
    
    cQryqRes += CRLF +"  GROUP BY pcq_vlrec "

 	If Select((cAliasqRes)) <> 0 
      
       (cAliasqRes)->(DbCloseArea()) 
 
 	Endif           
              
    TcQuery cQryqRes New Alias (cAliasqRes)            
    
 cqtdatot     :=    (cAliasqRes)->qtda 
 cSldDristA   :=    (cAliasqRes)->SALDO
 cVlrDistB    :=    (cAliasqRes)->TotLib
 cPercDistA   :=    (cAliasqRes)->TotPerc      

//// captura total da inhas 
	cQryqRes := CRLF +" SELECT  count(*) qtda  "
	cQryqRes += CRLF +"	  FROM " +RetSqlName('PCQ')+ " PCQ  "  
	cQryqRes += CRLF +"  WHERE PCQ_FILIAL = '"+xFilial('PCQ')+"' "
	cQryqRes += CRLF +"    AND PCQ.d_E_L_E_T_ = ' ' "
	cQryqRes += CRLF +"    AND PCQ_CPTPGT = '"+cCompt+"' "                        
    //cQryqRes += CRLF +"    AND trim(PCQ_STATU) = 'Ativo' and PCQ_SEQ = '"+cseq+"'" 
    cQryqRes += CRLF +"    AND PCQ_SEQ = '"+cseq+"'"

 	If Select((cAliasqRes1)) <> 0 
      
       (cAliasqRes1)->(DbCloseArea()) 
 
 	Endif           
              
    TcQuery cQryqRes New Alias (cAliasqRes1)                     


RETURN()                   

Static function fMovArqVar() 

     
      cCptcus         := PCQ->PCQ_CPTPGT  
  	  cClsRed         := PCQ->PCQ_CLSRED      
  	  cSeq            := PCQ->PCQ_SEQ       
  	  cDescItPg       := PCQ->PCQ_DESCP  
      nVlrLim         := PCQ->PCQ_VLRLI  
      nPercRec        := PCQ->PCQ_PERCU   
      nStatus         := PCQ->PCQ_STATU   
      cVLREC          := PCQ->PCQ_VLREC     
      cdia            := PCQ->PCQ_DIALIB    
      dDtCalen        := PCQ->PCQ_DTCALE 
      dDtpgto         := PCQ->PCQ_DTPGTO    
      
 Return
                                 
Static function fMovVarArq() 
   

nStatus:=fAtuaStatus()

If fcalPerTotal(cCptcus , str(cseq))
   
   reclock("PCQ",.F.)    
 
   PCQ->PCQ_CPTPGT := cCptcus     
   PCQ->PCQ_CLSRED := cClsRed         
   PCQ->PCQ_SEQ    := cSeq          
   PCQ->PCQ_DESCP  := cDescItPg    
   PCQ->PCQ_VLRLI  := nVlrLim     
   PCQ->PCQ_PERCU  := nPercRec    
   PCQ->PCQ_STATU  := nStatus     
   PCQ->PCQ_VLREC  := cVLREC        
   PCQ->PCQ_DIALIB := cdia                 
   PCQ->PCQ_DTCALE := dDtCalen       
   PCQ->PCQ_DTPGTO := dDtpgto       
      
   PCQ->(MsUnlock())  
 
   oDlg1:End()    
 
EndIf 
 
Return()  
 ////////
Static Function fCalcVal(nPercRec, cVLREC )
    
nVlrLim := (cVLREC * nPercRec) / 100

Return()                                 
/////                                         
Static Function fCalcperc(nVlrLim, cVLREC )
    
nPercRec := ( nVlrLim * 100) / cVLREC

Return()         

Static function fcalSe2(cCompt ,  cClsrde , cgrppag)
          


//	cQryqRSe2 := CRLF +"   SELECT substr(E2_pllote,1,6) , bau_GRPPAG ,  
	cQryqRSe2 := CRLF +"   SELECT  bau_GRPPAG , 
	if !empty(cClsrde)
        cQryqRSe2 += CRLF +"       e2_prefixo , "
    EndIf
	/*
	cQryqRSe2 += CRLF +"          SUM(CASE WHEN E2_SALDO = 0 THEN E2_VALOR  ELSE 0.00 END )PGTO  , "
    cQryqRSe2 += CRLF +"          SUM(CASE WHEN E2_SALDO > 0 AND E2_DATALIB >= '"+dDtatu+"' THEN E2_SALDO  ELSE 0.00 END )LIBERADO , "
    cQryqRSe2 += CRLF +"          SUM(CASE WHEN E2_SALDO > 0 AND (E2_DATALIB = ' ' or E2_DATALIB < '"+dDtatu+"' )  THEN E2_SALDO  ELSE 0.00 END )NAOLIBERADO "
    */
    
    cQryqRSe2 += CRLF +"          to_char(add_months(to_date('201706' ,'YYYYMM'),-0 ),'YYYYMM') Cmpatu  , "
    cQryqRSe2 += CRLF +"          to_char(add_months(to_date('201706' ,'YYYYMM'),-1 ),'YYYYMM') Cmpant1 , "
    cQryqRSe2 += CRLF +"          to_char(add_months(to_date('201706' ,'YYYYMM'),-2 ),'YYYYMM') Cmpant2 , "
    cQryqRSe2 += CRLF +"          to_char(add_months(to_date('201706' ,'YYYYMM'),-3 ),'YYYYMM') Cmpant3 , " 
          
    cQryqRSe2 += CRLF +"          sum(CASE WHEN e2_saldo = 0 THEN e2_valor  ELSE 0.00 END )pgto  , "
    cQryqRSe2 += CRLF +"          sum(CASE WHEN e2_saldo > 0 AND e2_datalib >= '20170703' THEN e2_saldo  ELSE 0.00 END )liberado , "
    cQryqRSe2 += CRLF +"          sum(CASE WHEN e2_saldo > 0 AND (e2_datalib = ' ' OR e2_datalib < '20170703' )  THEN e2_saldo  ELSE 0.00 END )naoliberado , "
          
    cQryqRSe2 += CRLF +"          sum(CASE WHEN e2_saldo > 0 AND (e2_datalib = ' ' OR e2_datalib < '20170703' ) AND to_char(add_months(to_date('201706' ,'YYYYMM'),-0 ),'YYYYMM') = substr(e2_pllote,1,6) THEN e2_saldo  ELSE 0.00 END )vlrcmpatu  , " 
    cQryqRSe2 += CRLF +"          sum(CASE WHEN e2_saldo > 0 AND (e2_datalib = ' ' OR e2_datalib < '20170703' ) AND to_char(add_months(to_date('201706' ,'YYYYMM'),-1 ),'YYYYMM') = substr(e2_pllote,1,6) THEN e2_saldo  ELSE 0.00 END )vlrcmpant1 , "     
    cQryqRSe2 += CRLF +"          sum(CASE WHEN e2_saldo > 0 AND (e2_datalib = ' ' OR e2_datalib < '20170703' ) AND to_char(add_months(to_date('201706' ,'YYYYMM'),-2 ),'YYYYMM') = substr(e2_pllote,1,6) THEN e2_saldo  ELSE 0.00 END )vlrcmpant2 , "     
    cQryqRSe2 += CRLF +"          sum(CASE WHEN e2_saldo > 0 AND (e2_datalib = ' ' OR e2_datalib < '20170703' ) AND to_char(add_months(to_date('201706' ,'YYYYMM'),-3 ),'YYYYMM') = substr(e2_pllote,1,6) THEN e2_saldo  ELSE 0.00 END )vlrcmpant3   "    
    
    cQryqRSe2 += CRLF +"     FROM  " +RetSqlName('SE2')+ " SE2  , " +RetSqlName('BAU')+ " BAU  "  
    cQryqRSe2 += CRLF +"    WHERE e2_filial  = '"+xFilial('SE2')+"'   AND SE2.d_E_L_E_T_ = ' '    "
    cQryqRSe2 += CRLF +"      AND bau_filial = '"+xFilial('BAU')+"'   AND BAU.d_E_L_E_T_ = ' '   "
                                                                         
    cQryqRSe2 += CRLF +"      AND substr(e2_pllote,1,6)<= '"+cCompt+"' AND substr(e2_pllote,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+cCompt+"' ,'YYYYMM'),-3 ),'YYYYMM') "
    
    cQryqRSe2 += CRLF +"      AND bau_grppag = '"+cgrppag+"' "   
    if !empty(cClsrde)
       cQryqRSe2 += CRLF +"   AND e2_prefixo = '"+trim(cClsrde)+"' " 
    EndIf                     
    
    cQryqRSe2 += CRLF +"     AND E2_TIPO = 'FT' "                          
    cQryqRSe2 += CRLF +"     AND E2_YLIBPLS IN ('L','S') "
    
    cQryqRSe2 += CRLF +"     AND BAU_codigo = e2_codrda  "

    cQryqRSe2 += CRLF +"    GROUP BY  bau_GRPPAG "
   if !empty(cClsrde)
      cQryqRSe2 += CRLF +"  ,  e2_prefixo "       
   EndIf                                                                 
   
    cQryqRSe2 += CRLF +"  , to_char(add_months(to_date('201706' ,'YYYYMM'),-0 ),'YYYYMM') , "
    cQryqRSe2 += CRLF +"    to_char(add_months(to_date('201706' ,'YYYYMM'),-1 ),'YYYYMM') , "
    cQryqRSe2 += CRLF +"    to_char(add_months(to_date('201706' ,'YYYYMM'),-2 ),'YYYYMM') , "
    cQryqRSe2 += CRLF +"    to_char(add_months(to_date('201706' ,'YYYYMM'),-3 ),'YYYYMM')   "
    
    
 	If Select((cAliasqSe2)) <> 0 
      
       (cAliasqSe2)->(DbCloseArea()) 
 
 	Endif           
              
    TcQuery cQryqRSe2 New Alias (cAliasqSe2)            
    
     cVlrpgto   := (cAliasqSe2)->PGTO
     cVlrLib    := (cAliasqSe2)->LIBERADO
     cVlrNLib   := (cAliasqSe2)->NAOLIBERADO      
     
     cVlCmpAnt1 := (cAliasqSe2)->vlrcmpant1
     cVlCmpAnt2 := (cAliasqSe2)->vlrcmpant2
     cVlCmpAnt3 := (cAliasqSe2)->vlrcmpant3
     cVlCmpAtu  := (cAliasqSe2)->vlrcmpatu   
           
     cCmpAnt1   := (cAliasqSe2)->Cmpant1
     cCmpAnt2   := (cAliasqSe2)->Cmpant2
     cCmpAnt3   := (cAliasqSe2)->Cmpant3
     cCmpAtu    := (cAliasqSe2)->Cmpatu

Return()              

/////// 

Static function fcalPerTotal(cCompt , cSeq )

local lRet:= .T.

	cQryqPer := CRLF +" SELECT  SUM(PCQ_PERCU) TotPerc "
	cQryqPer += CRLF +"	  FROM " +RetSqlName('PCQ')+ " PCQ  "  
	cQryqPer += CRLF +"  WHERE PCQ_FILIAL = '"+xFilial('PCQ')+"' "
	cQryqPer += CRLF +"    AND PCQ.d_E_L_E_T_ = ' ' "
	cQryqPer += CRLF +"    AND PCQ_CPTPGT = '"+cCompt+"' and PCQ_SEQ = '"+cSeq+"' " 
    cQryqPer += CRLF +"    AND trim(PCQ_STATU) = 'Ativo' "


 	If Select((cAliasqPer)) <> 0 
      
       (cAliasqPer)->(DbCloseArea()) 
 
 	Endif           
              
    TcQuery cQryqPer New Alias (cAliasqPer)        
            
    
    if ((cAliasqPer)->TotPerc + nPercRec) > 100     

        MsgAlert("O Percentual Total da Receita Distribuido para Competencia : "+cCompt+" Superou 100% , Esta Em : "+str((cAliasqPer)->TotPerc)+"% ","Atencao!")  
        
        If ApMsgYesNo("Deseja Mater esta Parametrização ? ","SIMNAO")
           lRet:= .T.
        Else         
           lRet:= .F.
        EndIf 
    EndIf      
               
Return(lRet)
/////

Static function fAtuaStatus()
 If  trim(nStatus) == 'Suspenso'  .and.   nPercRec > 0  
 
       MsgAlert("Esta Parametrização tera seu status atualizado para Ativo ","Atencao!") 		       
     
       nStatus := 'Ativo'
     
 ElseIf  trim(nStatus) == 'Ativo'  .and.   nPercRec == 0  
            
       MsgAlert("Esta Parametrização tera seu status atualizado para Suspenso ","Atencao!") 		       
     
       nStatus := 'Suspenso'
             
 EndIf     

Return(nStatus)                                 

///////////////////////////////////////
Static function fDeletaArq ()

	PCQ->(RecLock("PCQ",.F.))
	
	PCQ->(DbDelete())
	
	PCQ->(MsUnlock()) 
	
	oDlg1:Refresh()
	    
	fMovVarArq()  

Return()                    


//////////////////////////////////////////  


/*
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

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

//User Function NewSource

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
/*
Private cClsRed    := Space(1)
Private cCmpAnt1   := Space(1)
Private cCmpAnt2   := Space(1)
Private cCmpAnt3   := Space(1)
Private cCmpAtu    := Space(1)
Private cCptcus    := Space(1)
Private cDescItPg  := Space(1)
Private cdia       := Space(1)
Private cPercDistA := Space(1)
Private cqtdPrcpgt := Space(1)
Private cSeq       := Space(1)
Private cSldDristA := Space(1)
Private cVlCmpAnt1 := Space(1)
Private cVlCmpAnt2 := Space(1)
Private cVlCmpAnt3 := Space(1)
Private cVlCmpAtu  := Space(1)
Private cVlrDistB  := Space(1)
Private cVLREC     := Space(1)
Private cVlrLib    := Space(1)
Private cVlrNLib   := Space(1)
Private cVlrpgto   := Space(1)
Private dDtCalen   := CtoD(" ")
Private dDtpgto    := CtoD(" ")
Private nPercRec   := 0
Private nStatus   
Private nVlrLim    := 0

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
/*
SetPrvt("oDlg1","oSay20","oGrp1","oSay2","oSay6","oSay11","oSay46","oSay17","oSay1","oSay3","oSay4","oSay5")
SetPrvt("oSay8","oSay14","oSay15","oSay16","oGet2","oGet6","oGrp5","oBtn13","oBtn8","oBtn7","oCBox2")
SetPrvt("oGet17","oGet1","oGet3","oGet4","oGet5","oGet7","oGet8","oGrp2","oSay9","oSay10","oSay12","oSay13")
SetPrvt("oGet10","oGet11","oGet12","oGet13","oGet14","oGet15","oGrp3","oSay18","oSay19","oSay21","oSay22")
SetPrvt("oSay24","oSay25","oSay26","oGet16","oGet18","oGet20","oGet21","oGet22","oGet23","oGet24","oGet25")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
/*
oDlg1      := MSDialog():New( 255,356,532,1084,"Parametros de Pagamento ",,,.F.,,,,,,.T.,,,.T. )
oSay20     := TSay():New( 000,000,{||"Comp. Atual "},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGrp1      := TGroup():New( 000,000,092,356,"Manutenção dos Parametros",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay2      := TSay():New( 028,004,{||"Descrição Item Pagto   "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,064,008)
oSay6      := TSay():New( 048,039,{||"% da Receita   "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay11     := TSay():New( 007,140,{||"Status"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay46     := TSay():New( 048,004,{||"Clas. Rede"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay17     := TSay():New( 048,080,{||"Ate o Valor Limite "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay1      := TSay():New( 048,136,{||"Dia Lib "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay3      := TSay():New( 007,004,{||"Competencia"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay4      := TSay():New( 007,040,{||"Sequencia"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay5      := TSay():New( 007,076,{||"Vlr Receita"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay7      := TSay():New( 048,172,{||"Calendario Pgto "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay8      := TSay():New( 068,173,{||"Data  Pgto "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,035,008)
oSay14     := TSay():New( 068,004,{||"Vlr Liberado "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay15     := TSay():New( 068,057,{||"Vlr Pago "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay16     := TSay():New( 068,114,{||"Vlr N Lib"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet2      := TGet():New( 036,004,{|u| If(PCount()>0,cDescItPg:=u,cDescItPg)},oGrp1,208,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cDescItPg",,)
oGet6      := TGet():New( 056,040,{|u| If(PCount()>0,nPercRec:=u,nPercRec)},oGrp1,028,008,'@E 99.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,{|u| If(PCount()>0,nPercRec:=u,nPercRec)},.F.,.F.,"","nPercRec",,)
oGrp5      := TGroup():New( 004,288,088,352,"Menu ",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn13     := TButton():New( 068,300,"Sair",oGrp5,{||oDlg1:End()},044,012,,,,.T.,,"",,,,.F. )
oBtn8      := TButton():New( 044,300,"Deleta",oGrp5,{||fDeletaArq()},044,012,,,,.T.,,"",,,,.F. )
oBtn7      := TButton():New( 016,300,"Grava",oGrp5,{||fMovVarArq() },044,012,,,,.T.,,"",,,,.F. )
oCBox2     := TComboBox():New( 016,140,{|u| If(PCount()>0,nStatus:=u,nStatus)},{"Ativo","Concluido","Suspenso ","Cancelado"},072,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nStatus )
oGet39     := TGet():New( 056,004,{|u| If(PCount()>0,cClsRed:=u,cClsRed)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cClsRed",,)
oGet17     := TGet():New( 056,080,{|u| If(PCount()>0,nVlrLim:=u,nVlrLim)},oGrp1,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrLim",,)
oGet1      := TGet():New( 056,136,{|u| If(PCount()>0,cdia:=u,cdia)},oGrp1,020,008,'@E 99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cdia",,)
oGet3      := TGet():New( 016,004,{|u| If(PCount()>0,cCptcus:=u,cCptcus)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptcus",,)
oGet4      := TGet():New( 016,040,{|u| If(PCount()>0,cSeq:=u,cSeq)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSeq",,)
oGet5      := TGet():New( 016,076,{|u| If(PCount()>0,cVLREC:=u,cVLREC)},oGrp1,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVLREC",,)
oGet7      := TGet():New( 056,172,{|u| If(PCount()>0,dDtCalen:=u,dDtCalen)},oGrp1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtCalen",,)
oGet8      := TGet():New( 076,172,{|u| If(PCount()>0,dDtpgto:=u,dDtpgto)},oGrp1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtpgto",,)
oGrp2      := TGroup():New( 004,216,088,284,"Resumo da Competencia",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay9      := TSay():New( 011,220,{||"Qtda Processada/Total"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
oSay10     := TSay():New( 027,221,{||"Saldo A Distribuir."},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,055,008)
oSay12     := TSay():New( 045,221,{||"Valor Distribuido"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay13     := TSay():New( 066,221,{||"Percentual Distribuido "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oGet9      := TGet():New( 017,224,{|u| If(PCount()>0,cqtdPrcpgt:=u,cqtdPrcpgt)},oGrp2,056,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdPrcpgt",,)
oGet10     := TGet():New( 034,225,{|u| If(PCount()>0,cSldDristA:=u,cSldDristA)},oGrp2,055,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSldDristA",,)
oGet11     := TGet():New( 054,225,{|u| If(PCount()>0,cVlrDistB:=u,cVlrDistB)},oGrp2,055,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVlrDistB",,)
oGet12     := TGet():New( 074,225,{|u| If(PCount()>0,cPercDistA:=u,cPercDistA)},oGrp2,055,008,'@E 99,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cPercDistA",,)
oGet13     := TGet():New( 076,004,{|u| If(PCount()>0,cVlrLib:=u,cVlrLib)},oGrp1,044,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVlrLib",,)
oGet14     := TGet():New( 076,057,{|u| If(PCount()>0,cVlrpgto:=u,cVlrpgto)},oGrp1,052,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVlrpgto",,)
oGet15     := TGet():New( 076,114,{|u| If(PCount()>0,cVlrNLib:=u,cVlrNLib)},oGrp1,052,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVlrNLib",,)

oGrp3      := TGroup():New( 093,000,129,356,"Distribuição de Valores por Competencia ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay18     := TSay():New( 102,004,{||"Comp. Atual "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay19     := TSay():New( 102,042,{||"Vlr Comp. Atual "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay21     := TSay():New( 102,093,{||"Comp. Ant. 1"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay22     := TSay():New( 102,131,{||"Vlr Comp. Ant 1 "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay23     := TSay():New( 102,182,{||"Comp. Ant 2 "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,030,008)
oSay24     := TSay():New( 102,216,{||"Vlr Comp. Ant 2 "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay25     := TSay():New( 102,301,{||"Vlr Comp. Ant 3 "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay26     := TSay():New( 102,267,{||"Comp. Ant 3 "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oGet16     := TGet():New( 115,004,{|u| If(PCount()>0,cCmpAtu:=u,cCmpAtu)},oGrp3,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpAtu",,)
oGet18     := TGet():New( 115,041,{|u| If(PCount()>0,cVlCmpAtu:=u,cVlCmpAtu)},oGrp3,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cVlCmpAtu",,)
oGet20     := TGet():New( 115,093,{|u| If(PCount()>0,cCmpAnt1:=u,cCmpAnt1)},oGrp3,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpAnt1",,)
oGet21     := TGet():New( 115,130,{|u| If(PCount()>0,cVlCmpAnt1:=u,cVlCmpAnt1)},oGrp3,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cVlCmpAnt1",,)
oGet22     := TGet():New( 115,181,{|u| If(PCount()>0,cCmpAnt2:=u,cCmpAnt2)},oGrp3,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpAnt2",,)
oGet23     := TGet():New( 115,214,{|u| If(PCount()>0,cVlCmpAnt2:=u,cVlCmpAnt2)},oGrp3,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cVlCmpAnt2",,)
oGet24     := TGet():New( 115,303,{|u| If(PCount()>0,cVlCmpAnt3:=u,cVlCmpAnt3)},oGrp3,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cVlCmpAnt3",,)
oGet25     := TGet():New( 115,266,{|u| If(PCount()>0,cCmpAnt3:=u,cCmpAnt3)},oGrp3,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpAnt3",,)

oDlg1:Activate(,,,.T.)

Return
*/