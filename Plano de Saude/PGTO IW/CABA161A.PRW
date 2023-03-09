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

User Function caba161A()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cCmp       := Space(1)
Private cMensg    
Private nQtdaProf  := 0
Private nQtdprod   := 0
Private nVlTotProc := 0

Private cCmpCab    := Space(1)  
Private cCmpInt    := Space(1)  
Private cCmpIW     := Space(1)
Private cStCmp     := Space(1)  

Private cAliastmp  := GetNextAlias()
Private cAliasTot  := GetNextAlias()
Private cAliasIw   := GetNextAlias()  

Private cAliasCmp  := GetNextAlias()

Private cEmp       := cEmpAnt  
private lPVez      := .T.
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oGrp1","oGrp2","oBtn1","oBtn2","oBtn3","oBtn4","oBtn5","oBtn6","oBtn7","oBtn8","oGrp3")
SetPrvt("oSay2","oSay3","oSay4","oSay5","oSay6","oSay7","oGet1","oGet2","oGet3","oGet4","oGet5","oGet6")
SetPrvt("oGrp4", "oMGet1")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
 

 for i:=1 to 5
	
    IncProc('Buscando Dados no Servidor ...')

next

   fAchaComp1()  

   flotPgto()

/*
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

*/
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg1      := MSDialog():New( 093,229,445,963,"Central De Processamento do IW",,,.F.,,,,,,.T.,,,.T. ) 
oGrp1      := TGroup():New( 000,000,168,360,"Controle Do Processo Do IW",oDlg1,CLR_RED,CLR_WHITE,.T.,.F. )
oGrp2      := TGroup():New( 008,008,164,120,"Ações Possiveis ",oGrp1,CLR_GREEN,CLR_WHITE,.T.,.F. )
oBtn1      := TButton():New( 016,015,"Manut. De -> Para (IW -> RDA) ",oGrp2,{||fCABA159()},099,016,,,,.T.,,"CABA159 - Manutenção da Relação do ProFisional Iw com Rda Caberj / Integral",,,,.F. )
oBtn2      := TButton():New( 034,015,"Replicar Cadastro de Remuneração",oGrp2,{||fCABA162(1)},099,016,,,,.T.,,"CABA162(1) - Replica Cadastro de Remuneraçõa / carga movimento Iw",,,,.F. )
oBtn3      := TButton():New( 069,015,"Carregar Movimento IW",oGrp2,{||fCABA162(2)},099,016,,,,.T.,,"CABA162(2) - Carga do Mivimeto do IW ",,,,.F. )
oBtn4      := TButton():New( 051,015,"Manut. Cadastro de Remuneração",oGrp2,{||fCABA160()},099,016,,,,.T.,,"CABA160 - Manutenção da Relmuneração ",,,,.F. )
oBtn5      := TButton():New( 086,015,"Gerar Movimentos de Pag / Rec",oGrp2,{||fCABA163()},099,016,,,,.T.,,"CABA163-Gera Movimetos de Pagamento / Recebimentos ",,,,.F. )
oBtn6      := TButton():New( 103,015,"Cadastro de Movimentos de Pag / Rec",oGrp2,{||fCABA164()},099,016,,,,.T.,,"CABA164-Cadastro de Mivimento de pagamento",,,,.F. )
oBtn7      := TButton():New( 121,015,"Efetiva Lançamento de Pag / Rec",oGrp2,{||fCABA165()},099,016,,,,.T.,,"CABA165 - Efetiva Lanc. Deb/Cred ",,,,.F. )
oBtn8      := TButton():New( 147,015,"Desfaz Lançametos ",oGrp2,,096,012,,,,.T.,,"",,,,.F. )
If subStr(cUSUARIO,7,15) == 'Altamiro Totta '
   oBtn8:enable()
Else   
   oBtn8:Disable()
EndIf    
oGrp3      := TGroup():New( 008,124,164,216,"Parametros do Processamento",oGrp1,CLR_GREEN,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 016,130,{||"Compte. IW"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay2      := TSay():New( 038,130,{||"Compte. Custo CABERJ"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay3      := TSay():New( 060,130,{||"Compte. Custo INTEGRAL"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,066,008)
oSay4      := TSay():New( 082,130,{||"Qtd De Profissionais"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,049,008)
oSay5      := TSay():New( 104,130,{||"Vlr Total Processado"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,049,008)
oSay6      := TSay():New( 123,130,{||"Qtda Total De Procedimentos"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,074,008)
oSay7      := TSay():New( 143,130,{||"Status da Competencia "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oGet1      := TGet():New( 025,130,{|u| If(PCount()>0,cCmpIW  :=u,cCmpIW  )},oGrp3,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpIW  ",,)
oGet2      := TGet():New( 047,130,{|u| If(PCount()>0,cCmpCab:=u,cCmpCab)},oGrp3,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpCab",,)
oGet3      := TGet():New( 069,130,{|u| If(PCount()>0,cCmpInt:=u,cCmpInt)},oGrp3,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCmpInt",,)
oGet4      := TGet():New( 091,130,{|u| If(PCount()>0,cQtdaProf:=u,nQtdaProf)},oGrp3,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQtdaProf",,)
oGet5      := TGet():New( 113,130,{|u| If(PCount()>0,cVlTotProc:=u,nVlTotProc)},oGrp3,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cVlTotProc",,)
oGet6      := TGet():New( 131,130,{|u| If(PCount()>0,nQtdprod:=u,nQtdprod)},oGrp3,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nQtdprod",,)

If  trim(cStCmp) == 'Processada' 
    oGet7      := TGet():New( 151,130,{|u| If(PCount()>0,cStCmp:=u,cStCmp)},oGrp3,060,008,'',,CLR_HRED,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cStCmp",,)

oBtn3:Disable()
oBtn4:Disable()
oBtn5:Disable()
oBtn6:Disable()
oBtn7:Disable()

   If cempant == '02'
      oBtn7:enable()
   EndIf 

ElseIf  nQtdaProf == 0

oBtn5:Disable()
oBtn6:Disable()
oBtn7:Disable()

Else
    oGet7      := TGet():New( 151,130,{|u| If(PCount()>0,cStCmp:=u,cStCmp)},oGrp3,060,008,'',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cStCmp",,)
EndIf

oGrp4      := TGroup():New( 008,220,164,356,"Mensagem do Sistema ",oGrp1,CLR_GREEN,CLR_WHITE,.T.,.F. )

oMGet1     := TMultiGet():New( 016,224,{|u| If(PCount()>0,cMensg:=u,cMensg)},oGrp4,128,144,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

/*
If lPVez 

   cMensg:=       '      A T E N Ç Ã O  '
   cMensg+= CRLF +' Buscando Dados no Servidor '
   cMensg+= CRLF +' '
   cMensg+= CRLF +'    A G U A R D E !!! '
   cMensg+= CRLF +' '
  
   oMGet1:refresh()



   lPVez  := .F.

EndIf
*/   

    cMensg:= CRLF + CRLF + ' Escolha uma Opção .... '
   
    oMGet1:refresh() 


oDlg1:Activate(,,,.T.)  


Return

Static Function fCaba165()   
   
   cMensg:='Efetiva os Lançamentos de Pagamentos ao (Debitos) '
   cMensg+= CRLF +'e lançamentos de Recebimentos (creditos)'
   cMensg+= CRLF +'onde os debito na Caberj Iram Pagar ao RDAs'
   cMensg+= CRLF +',os debito na integral Iram resarci a Caberj'
   cMensg+= CRLF +' e os creditos na Caberj Iram Cobrar a Integral'
  
   oMGet1:refresh()

If  ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")

    cMensg:=       '      A T E N Ç Ã O  '
    cMensg+= CRLF +' Buscando Dados no Servidor '
    cMensg+= CRLF +' '
    cMensg+= CRLF +'    A G U A R D E !!! '
    cMensg+= CRLF +' '
  
    oMGet1:refresh()

     U_Caba165()    

    cMensg:=' ' 

    oMGet1:refresh()

EndIf       

    cMensg:=' '
   
    oMGet1:refresh()     


Return 

Static Function fCaba164()
   
   cMensg:='Visualização dos Lançamento de Pagamentos ao (Debitos) '
   cMensg+= CRLF +'e lançamentos de Recebimentos (creditos), '
   cMensg+= CRLF +'Gerados '

If ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")
  
    cMensg:=       '      A T E N Ç Ã O  '
    cMensg+= CRLF +' Buscando Dados no Servidor '
    cMensg+= CRLF +' '
    cMensg+= CRLF +'    A G U A R D E !!! '
    cMensg+= CRLF +' '
  
    oMGet1:refresh()

    U_Caba164(cCmp)      
   
    cMensg:=' '

    oMGet1:refresh()  
  
EndIf        

    cMensg:=' '
   
    oMGet1:refresh()     

Return 

Static Function fCaba163()
   
   cMensg:='Gera Lançamento de Pagamentos ao (Debitos) '
   cMensg+= CRLF +'e lançamentos de Recebimentos (creditos)'
   cMensg+= CRLF +'onde os debito na Caberj Iram Pagar ao RDAs'
   cMensg+= CRLF +',os debito na integral Iram resarci a Caberj'
   cMensg+= CRLF +' e os creditos na Caberj Iram Cobrar a Integral'

   oMGet1:refresh()

If  ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")
   
    cMensg:=       '      A T E N Ç Ã O  '
    cMensg+= CRLF +' Buscando Dados no Servidor '
    cMensg+= CRLF +' '
    cMensg+= CRLF +'    A G U A R D E !!! '
    cMensg+= CRLF +' '
  
    oMGet1:refresh()
    
     U_Caba163()

    cMensg:=' '
   
    oMGet1:refresh()

EndIf 

    cMensg:=' '
   
    oMGet1:refresh()     

Return 

Static Function fCaba162(controle)
    If controle == 1

       cMensg:='Replica o Cadastro de valores '
       cMensg+= CRLF +'de Pagamento Mensais   '

    Else 
       
       cMensg:= CRLF +'Importa a movimentação IW '

    EndIf

      oMGet1:refresh()

    If  ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")

        cMensg:=       '        A T E N Ç Ã O  '
        cMensg+= CRLF +' Buscando Dados no Servidor '
        cMensg+= CRLF +'        A G U A R D E !!! '
        cMensg+= CRLF +' '
  
        oMGet1:refresh()

//        U_Caba162(Controle)  

        Processa({||Proces162(Controle)},"Buscando Dados no Servidor", "Aguarde ....", .T.)   
        MsgInfo("Processo finalizado")

        fAchaComp1() 

        oBtn3:Enable()
        oBtn4:Enable()
        oBtn5:Enable()
        oBtn6:Enable()
        oBtn7:Enable()
        
        If subStr(cUSUARIO,7,15) == 'Altamiro Totta '
          oBtn8:Enable()
        Else   
          oBtn8:Disable()
        EndIf       
   
        cMensg:=' '
   
        oMGet1:refresh()
   
    EndIf 

    cMensg:=' '
   
    oMGet1:refresh()       
       
Return 


static function Proces162(Controle)

      U_Caba162(Controle)  

Return


Static Function fCaba160()
   
   cMensg:='Faz Manutenção Nos valores '
   cMensg+= CRLF +'de Pagamento Mensais '
   
   oMGet1:refresh()
  
If ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")
  
   U_Caba160(cCmp)       
   
   fAchaComp1()
   
   cMensg:=' '
   
   oMGet1:refresh()

EndIf

    cMensg:=' '
   
    oMGet1:refresh()     

Return 

Static Function fCaba159()
   
   cMensg:='Faz Vinculação entre o profissional '
   cMensg+= CRLF +'cadastrado no Iw e o RDA de pagamento '+ CRLF + CRLF 

   oMGet1:refresh()
  
    If ApMsgYesNo(cMensg + CRLF + CRLF + "Deseja Executar este Programa ?","SIMNAO")
  
       U_Caba159()      
   
       fAchaComp1()
   
       cMensg:=' '
   
       oMGet1:refresh()
  
    EndIf

    cMensg:=' '
   
    oMGet1:refresh()     

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
     

     //competencia IW 
     If cmes < 12
        cmes++
     Else     
        cano++
        cmes:= 01
     EndIf
     
     cCompte := strzero(cano,4)+strzero(cmes,2)

     //competencia caberj 
     If (cmes+1) < 12
        cmes++
     Else     
        cano++
        cmes:= 01
     EndIf 
     
     cCompte1 := strzero(cano,4)+strzero(cmes,2)

     //competencia integral 
     If (cmes+2) < 12
        cmes++
     Else     
        cano++
        cmes:= 01
     EndIf 
     cCompte2:= strzero(cano,4)+strzero(cmes,2)
     
     

  //   cCompte :='201910'        
  
     cQuery1 := CRLF + "    SELECT nvl(count(*),0) qtda , nvl(sum(pdj_vlrcmp),0.00) VlrCmp " 
     cQuery1 += CRLF + "      FROM "+ RetSqlName("PDJ") +" PDJ " 
     cQuery1 += CRLF + "     WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "' AND D_e_l_e_t_ = ' ' "   
     cQuery1 += CRLF + "       AND pdj_compte = '"+cCompte+"' and pdj_vlrcmp > 0 "  

     If Select((cAliasTot)) <> 0 
   
        (cAliasTot)->(DbCloseArea())  
  
     Endif 
        
     TCQuery cQuery1  New Alias (cAliasTot)     

     (cAliasTot)->(dbGoTop()) 
      
      If (cAliasTot)->(!EOF()) .and. (cAliasTot)->qtda > 0
   
         cCmp       := cCompte
         cCmpIW     := cCompte
         cCmpCab    := cCompte1
         cCmpInt    := cCompte2
         cStCmp     := 'Em processamento'
         nQtdaProf  := (cAliasTot)->qtda
         nQtdprod   := fDadosIw(cCompte)
         nVlTotProc := allTrim(Transform((cAliasTot)->VlrCmp,'@E 999,999,999.99')) 
             
      Else  
      
       cQuery2 := CRLF + "    SELECT count(*)qtda , sum(pdj_vlrcmp)VlrCmp " 
       cQuery2 += CRLF + "      FROM "+ RetSqlName("PDJ") +" PDJ " 
       cQuery2 += CRLF + "     WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "' AND D_e_l_e_t_ = ' ' "   
       cQuery2 += CRLF + "       AND pdj_compte = '"+trim((cAliasCmp)->COMPTE)+"'  and pdj_vlrcmp > 0 "  

       If Select((cAliasTot)) <> 0 
   
         (cAliasTot)->(DbCloseArea())  
  
       Endif 
        
       TCQuery cQuery2  New Alias (cAliasTot)   

      (cAliasTot)->(dbGoTop()) 
      
      If (cAliasTot)->(!EOF()) 
      
          cCmp     := trim((cAliasCmp)->COMPTE)

        cCmpIW     := trim((cAliasCmp)->COMPTE)
        cCmpCab    := cCompte
        cCmpInt    := cCompte1

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


///////////////////////////////////////////////
// DESFAZER LANÇAMENTO DO IW 

static function LimLanc()

local cAPdmBgqC := GetNextAlias()
local cAPdmBgqI := GetNextAlias()
local cAPdmBsqC := GetNextAlias()
local cAliaPdjC := GetNextAlias()
local cAliaIWC  := GetNextAlias()

local cQryBgqC := ' '
local cQryBgqI := ' '
local cQryBsqC := ' '
local cQryPdjC := ' '
local cQryIWC  := ' ' 
local cScript  := ' '

local lFaz     := .T.

/// PDM BGQ CABERJ 
       cQryBgqC := CRLF + "    SELECT SUM(PDM_VALOR)  " 
       cQryBgqC += CRLF + "      FROM "+ RetSqlName("PDM") +" PDM " 
       cQryBgqC += CRLF + "     WHERE PDM_FILIAL = '" + xFilial("PDM") + "'"   
       cQryBgqC += CRLF + "       AND d_E_L_E_T_ =' ' 
       cQryBgqC += CRLF + "       and pdm_cabint ='1' and pdm_alias = 'BGQ' AND PDM_SEQDB = ' ' "
       cQryBgqC += CRLF + "       AND PDM_compte = '"+cCompte1+"'"  

        If Select((cAPdmBgqC)) <> 0 
   
           (cAPdmBgqC)->(DbCloseArea())  
  
        Endif 
        
        TCQuery cQryBgqC  New Alias (cAPdmBgqC)   

        (cAPdmBgqC)->(dbGoTop()) 
      
        If (cAPdmBgqC)->(!EOF()) 

           cScript  := CRLF + "    update "+ RetSqlName("PDM") +" PDM "
           cScript  += CRLF + "     set D_E_L_E_T_ = '*' , r_E_C_D_E_L_ = 0 " 
           cScript  += CRLF + "     WHERE PDM_FILIAL = '" + xFilial("PDM") + "'"   
           cScript  += CRLF + "       AND d_E_L_E_T_ = ' ' 
           cScript  += CRLF + "       and pdm_cabint = '1' and pdm_alias = 'BGQ' AND PDM_SEQDB = ' ' "
           cScript  += CRLF + "       AND PDM_compte = '"+cCompte1+"'"  

   
           nSucesso:= tcsqlexec(cScript)
	
            If nSucesso == 0
	 
               MsgStop("Excluido , PDM CABERJ BGQ  !!! , Competencia '"+cCompte1+"  Concluida .... ")
	   	
            Else 		                                          
	
               MsgAlert("F A L H A  !!! PDM CABERJ BGQ  !!! , Competencia '"+cCompte1+"  FALHOU .... ")

               lFaz := .F.
   
            EndIf

        EndIf	

If lFaz

/// PDM BGQ INTEGRAL
       cQryBgqI := CRLF + "    SELECT SUM(PDM_VALOR)  " 
       cQryBgqI += CRLF + "      FROM "+ RetSqlName("PDM") +" PDM " 
       cQryBgqI += CRLF + "     WHERE PDM_FILIAL = '" + xFilial("PDM") + "'"   
       cQryBgqI += CRLF + "       AND d_E_L_E_T_ =' ' 
       cQryBgqI += CRLF + "       and pdm_cabint ='2' and pdm_alias = 'BGQ' AND PDM_SEQDB = ' ' "
       cQryBgqI += CRLF + "       AND PDM_compte = '"+cCompte2+"'"  

        If Select((cAPdmBgqI)) <> 0 
   
           (cAPdmBgqI)->(DbCloseArea())  
  
        Endif 
        
        TCQuery cQryBgqI  New Alias (cAPdmBgqI)   

        (cAPdmBgqI)->(dbGoTop()) 
      
        If (cAPdmBgqI)->(!EOF()) 

           cScript  := CRLF + "    update "+ RetSqlName("PDM") +" PDM "
           cScript  += CRLF + "     set D_E_L_E_T_ = '*' , r_E_C_D_E_L_ = 0 " 
           cScript  += CRLF + "     WHERE PDM_FILIAL = '" + xFilial("PDM") + "'"   
           cScript  += CRLF + "       AND d_E_L_E_T_ = ' ' 
           cScript  += CRLF + "       and pdm_cabint = '2' and pdm_alias = 'BGQ' AND PDM_SEQDB = ' ' "
           cScript  += CRLF + "       AND PDM_compte = '"+cCompte2+"'"  

   
           nSucesso:= tcsqlexec(cScript)
	
            If nSucesso == 0
	 
               MsgStop("Excluido , PDM INTEGRAL BGQ  !!! , Competencia '"+cCompte2+"  Concluida .... ")
	   	
            Else 		                                          
	
               MsgAlert("F A L H A  !!! PDM INTEGRAL BGQ  !!! , Competencia '"+cCompte2+"  FALHOU .... ")
	        
               lFaz := .F.

            EndIf

        EndIf	 

    If lFaz 

/// PDM BSQ CABERJ
 
       cQryBsqC := CRLF + "    SELECT SUM(PDM_VALOR)  " 
       cQryBsqC += CRLF + "      FROM "+ RetSqlName("PDM") +" PDM " 
       cQryBsqC += CRLF + "     WHERE PDM_FILIAL = '" + xFilial("PDM") + "'"   
       cQryBsqC += CRLF + "       AND d_E_L_E_T_ =' ' 
       cQryBsqC += CRLF + "       and pdm_cabint ='1' and pdm_alias = 'BSQ' AND PDM_SEQDB = ' ' "
       cQryBsqC += CRLF + "       AND PDM_compte = '"+cCompte2+"'"  

        If Select((cAPdmBsqC)) <> 0 
   
           (cAPdmBsqC)->(DbCloseArea())  
  
        Endif 
        
        TCQuery cQryBsqC  New Alias (cAPdmBsqC)   

        (cAPdmBsqC)->(dbGoTop()) 
      
        If (cAPdmBsqC)->(!EOF()) 

           cScript  := CRLF + "    update "+ RetSqlName("PDM") +" PDM "
           cScript  += CRLF + "     set D_E_L_E_T_ = '*' , r_E_C_D_E_L_ = 0 " 
           cScript  += CRLF + "     WHERE PDM_FILIAL = '" + xFilial("PDM") + "'"   
           cScript  += CRLF + "       AND d_E_L_E_T_ = ' ' 
           cScript  += CRLF + "       and pdm_cabint = '1' and pdm_alias = 'BSQ' AND PDM_SEQDB = ' ' "
           cScript  += CRLF + "       AND PDM_compte = '"+cCompte2+"'"  

   
           nSucesso:= tcsqlexec(cScript)
	
            If nSucesso == 0
	 
               MsgStop("Excluido , PDM CABERJ BSQ  !!! , Competencia '"+cCompte2+"  Concluida .... ")
	   	
            Else 		                                          
	
               MsgAlert("F A L H A  !!! PDM CABERJ BSQ  !!! , Competencia '"+cCompte2+"  FALHOU .... ")
               
               lFaz := .F.

            EndIf

        EndIf	

        If lfaz

/// LIMPA PDJ CABERJ

            cQryPdjC := CRLF + "    SELECT *   " 
            cQryPdjC += CRLF + "      FROM "+ RetSqlName("PDJ") +" PDJ " 
            cQryPdjC += CRLF + "     WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'"   
            cQryPdjC += CRLF + "       AND d_E_L_E_T_ =' ' 
            cQryPdjC += CRLF + "       AND PDJ_compte = '"+cCompte+"'"  

            If Select((cAliaPdjC )) <> 0 
        
                (cAliaPdjC)->(DbCloseArea())  
        
            Endif 
                
            TCQuery cQryPdjC  New Alias (cAliaPdjC)   

            (cAliaPdjC)->(dbGoTop()) 
            
            If (cAliaPdjC)->(!EOF()) 

                cScript  := CRLF + "    update "+ RetSqlName("PDJ") +" PDJ "
                cScript  += CRLF + "     set pdj_vlruni = 0 , pdj_qtdprc = 0  " 
                cScript  += CRLF + "     WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'"   
                cScript  += CRLF + "       AND d_E_L_E_T_ = ' ' 
                cScript  += CRLF + "       AND PDJ_compte = '"+cCompte+"'"  
        
                nSucesso:= tcsqlexec(cScript)
            
                If nSucesso == 0
            
                   MsgStop("LIMPEZA  , PDJ CABERJ  !!! , Competencia '"+cCompte+"  Concluida .... ")
                
                Else 		                                          
            
                    MsgAlert("F A L H A  !!! PDMJ CABERJ  !!! , Competencia '"+cCompte+"  FALHOU .... ")
                    
                    lFaz := .F.
                    
                EndIf

            EndIf	

            If lFaz

/// EXCLUSAO MOV IW  CABERJ 

                cQryIWC  := CRLF + "    SELECT *  FROM MOVIW WHERE COMPTE = '"+cCompte+"'"  

                If Select((cAliaIWC)) <> 0 
            
                    (cAliaIWC)->(DbCloseArea())  
            
                Endif 
                    
                TCQuery cQryIWC  New Alias (cAliaIWC)   

                (cAliaIWC)->(dbGoTop()) 
                
                If (cAliaIWC)->(!EOF()) 

                    cScript  := CRLF + " delete MOVIW WHERE COMPTE = '"+cCompte+"'"  

                    nSucesso:= tcsqlexec(cScript)
                
                    If nSucesso == 0
                
                        MsgStop("Excluido , MOVIW CABERJ  !!! , Competencia '"+cCompte+"  Concluida .... ")
                    
                    Else 		                                          
                
                        MsgAlert("F A L H A  !!! MOVIW CABERJ  !!! , Competencia '"+cCompte+"  FALHOU .... ")
                
                    EndIf

                EndIf
            EndIf
        EndIf
    EndIf
EndIf           

Return()

Static Function flotPgto()  

local cQry      := ' ' 
local cAliaPDM  := GetNextAlias()
local cEmp      := iif (cEmpAnt == '01','1','2') 
local cCobPag   := ' ' 
    
    cQry := CRLF + " select pdm_alias alias , pdm_seqdb seqdb , pdm_cabint cabint , r_e_c_n_o_ RecPDM "
    cQry += CRLF + "   from  "+ RetSqlName("PDM") +" PDM " 
    cQry += CRLF + "  where PDM_FILIAL = '" + xFilial("PDM") + "' and d_E_L_E_T_ = ' '"
    cQry += CRLF + "    and PDM_seqdb <> ' ' and PDM_lotpag = ' ' and PDM_CABINT = '"+cEmp+"'" 
    cQry += CRLF + "  order by PDM_cabint , PDM_alias

    If  Select((cAliaPDM )) <> 0 
        
        (cAliaPDM)->(DbCloseArea())  
        
    Endif 
                
    TCQuery cQry  New Alias (cAliaPDM)   

    (cAliaPDM)->(dbGoTop()) 
            
    While  (cAliaPDM)->(!EOF()) 

        If (cAliaPDM)->alias == 'BSQ'
		    
            dbSelectArea("BSQ")
		    dbSetOrder(1)
		
            If dbSeek( xFilial("BSQ") + (cAliaPDM)->seqdb )
	
	            cCobPag := BSQ_NUMCOB

            Else 

                cCobPag := ' ' 

            EndIf

        ElseIf (cAliaPDM)->alias == 'BGQ'
		    
            dbSelectArea("BGQ")
		    dbSetOrder(1)
		
            If dbSeek( xFilial("BGQ") + (cAliaPDM)->seqdb )
	
	            cCobPag := BGQ_NUMLOT 

            Else 

                cCobPag := ' ' 

            Endif 

        EndIf

	    PDM->(DbGoto((cAliaPDM)->RecPDM))
	        
   	    PDM->(Reclock("PDM",.F.))

            PDM->pdm_lotpag := cCobPag
		              
        PDM->(MSUNLOCK())          

	    
        (cAliaPDM)->(DbSkip())
		
	EndDo        
	            

Return()
/*

select SUM(PDM_VALOR) from pdm010 where pdm_filial =' ' and d_E_L_E_T_ =' '  and pdm_compte = '202004' and pdm_cabint ='1' and pdm_alias = 'BGQ' 

--delete pdm010 where pdm_filial =' ' and d_E_L_E_T_ =' '  and pdm_compte = '202004' and pdm_cabint ='1' and pdm_alias = 'BGQ' 



;
select SUM(PDM_VALOR) from pdm010 where pdm_filial =' ' and d_E_L_E_T_ =' '  and pdm_compte = '202005' and pdm_cabint ='2' and pdm_alias = 'BGQ' 

--delete pdm010 where pdm_filial =' ' and d_E_L_E_T_ =' '  and pdm_compte = '202005' and pdm_cabint ='2' and pdm_alias = 'BGQ' 



;
select SUM(PDM_VALOR) from pdm010 where pdm_filial =' ' and d_E_L_E_T_ =' '  and pdm_compte = '202005' and pdm_cabint ='1' and pdm_alias = 'BSQ' 

--delete pdm010 where pdm_filial =' ' and d_E_L_E_T_ =' '  and pdm_compte = '202005' and pdm_cabint ='1' and pdm_alias = 'BSQ' 



;
SELECT * FROM PDJ010 WHERE PDJ_FILIAL = ' ' AND D_e_l_e_t_ = ' ' AND PDJ_COMPTE = '202003' 

--update pdj010 set pdj_vlruni = 0 , pdj_qtdprc = 0  WHERE PDJ_FILIAL = ' ' AND D_e_l_e_t_ = ' ' AND PDJ_COMPTE = '202003'


;
SELECT * FROM MOVIW WHERE COMPTE = '202003'

--delete MOVIW WHERE COMPTE = '202003'

;
*/