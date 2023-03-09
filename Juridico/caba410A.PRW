#include "PLSA090.ch"
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE 'TOPCONN.CH'
#Include "Ap5Mail.Ch"

#Define CRLF Chr(13)+Chr(10)
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³          ³ Autor ³                       ³ Data ³          ³±±
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

//Atenção - Angelo HEnrique - 13/09/2022
//Rotina atualizada para versionamento e atender a verão 33 do protheus
//Removido variáveis desnecessárias e sem utilização
//Rmovido funções duplicadas e cxomentadas.

User Function caba410A(cAlias,nReg,nOpc)               

                                                                                                               
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄoÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/         
Private cBairVara  := Space(20)
Private cCC1       := Space(4)
Private cCC2       := Space(6)
Private cCC3       := Space(6)
Private cCC4       := Space(6)
Private cCC5       := Space(6)
Private cCcDesc1   := Space(1)
Private cCcDesc2   := Space(1)
Private cCcDesc3   := Space(1)
Private cCcDesc4   := Space(1)
Private cCcDesc5   := Space(1)
Private cCep       := Space(8)
Private cCodVara   := Space(10)
Private cCpfCnpj1  := Space(19)
Private cCpfCnpj2  := Space(19)
Private cCpfCnpj3  := Space(19)
Private cCpfCnpj4  := Space(19)
Private cDescAut1  := Space(50)
Private cDescAut2  := Space(50)
Private cDescAut3  := Space(50)
Private cDescAut4  := Space(50)
Private cDescAut5  := Space(50)
Private cDescProc 
Private cDescTut  
Private cEndVara   := Space(50)
Private cForCli1   := Space(6)
Private cForCli2   := Space(6)
Private cForCli3   := Space(6)
Private cForCli4   := Space(6)
Private cForCli5   := Space(6)
Private cHoraCump  := 0
Private cHoraRec   := 0
Private cIdentAut1 := Space(20)
Private cIdentAut2 := Space(20)
Private cIdentAut3 := Space(20)
Private cIdentAut4 := Space(20)
Private cIdentAut5 := Space(20)
Private cMunVara   := Space(20)
Private cNomeReus1 := Space(50)
Private cNomeReus2 := Space(50)
Private cNomeReus3 := Space(50)
Private cNomeReus4 := Space(50)
Private nNumCab    := 0
Private cNumComPr  := Space(20)
Private cNumproc   := Space(30)
Private cNumvara   := 0
Private cPlaUsuAt1 := Space(30)
Private cPlaUsuAt2 := Space(30)
Private cPlaUsuAt3 := Space(30)
Private cPlaUsuAt4 := Space(30)
Private cPlaUsuAt5 := Space(30)
Private cPlaUsuOr1 := Space(30)
Private cPlaUsuOr2 := Space(30)
Private cPlaUsuOr3 := Space(30)  
Private cPlaUsuOr4 := Space(30)
Private cPlaUsuOr5 := Space(30)
Private cTemaed    := Space(1)
private cStatusANS := Space(20)
Private cSent1    
Private cSent2   
Private cdesdob   
Private cAudPraz     
Private cOnuscausa
Private cSenha1
Private cUfVara    := Space(1)
Private dDtArq     := CtoD(" ")
Private dDtCumpTut := CtoD(" ")
Private dDtDist    := CtoD(" ")
Private dDtRec     := CtoD(" ")
Private dDtSent1   := CtoD(" ")
Private dDtsent2   := CtoD(" ")
Private lEmail1    := .F.
Private lEmail2    := .F.
Private lEmail3    := .F.
Private lEmail4    := .F.
Private lEmail5    := .F.
Private lOrigem1   := .F.
Private lOrigem2   := .F.
Private lOrigem3   := .F.
Private lOrigem4   := .F.
Private lOrigem5   := .F.
Private nAcao1in1
Private nAcao1in2
Private nAcao1in3
Private nAcao1in4
Private nAcao1in5
Private nAcao2in1
Private nAcao2in2
Private nAcao2in3
Private nAcao2in4
Private nAcao2in5
Private nAcaoTut1 
Private nAcaoTut2 
Private nAcaoTut3 
Private nAcaoTut4 
Private nAcaoTut5 
Private nAsProc   := ' ' 
Private nComTut   
Private nDanMat   
Private nDanMora  
Private nIdentVara  
Private nSusTut   
Private nTipoReus1 := ' ' 
Private nTipoReus2 := ' '
Private nTipoReus3 := ' '
Private nTipoReus4 := ' '
Private nTpAutor  
Private nTpProc   
Private nTpSent1  
Private nTpSent2  
Private nVlrMat    := 0
Private nVlrmoral  := 0
Private nVlrProc   := 0   
Private nVlrEsc    := 0.00
private cNumCab    := 0  
private nEAdvog    

private cNCab411   := 0
private cNproc411  := ' '
private cNCompP411 := ' ' 

private lDesdob   := .F.
private lsair     := .T.
private nOpcm     := nOpc   
private cConcAut  := " "      
private cConcreu  := " "     
private lPassou   := .F.     
private cEmailCtt1:=''  
private cEmailCtt2:='' 
private cEmailCtt3:='' 
private cEmailCtt4:='' 
private cEmailCtt5:=''   

private lCritHora :=.F.    
private ddatatu   := DATE() 

private aProcFor  := {}

private aTema     := {""}
private aStatusAns   := {""}
private aAssunto:= {""}
private aTpProc := {""}
private aSenten := {""}

private _cMensAut := ' ' 
private _cMenspro := ' ' 

Private nStatus     
Private nTema     

private cEmpresa  := Iif(cEmpAnt == '01','C','I')   
PRIVATE cAliastmp1:= GetNextAlias()  
private _cMailCpju:= GetMv("MV_MLCPJU")  
private _cEnvMail := trim(GetMv("MV_ENEINC"))                 
                                                 
private cUsu410   := subStr(cUSUARIO,7,15)  
private cUsu410J  := trim(GetMv("MV_USRJUR"))                                          
private cUsu410F  := trim(GetMv("MV_USRFIN"))  
private cUsu410R  := trim(GetMv("MV_USRREG"))  
                                       
Private aParcela  :={'1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}
private nNumParc  := 0


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oGrp1","oCC1","oCC2","oCC4","oCC3","oCC5","oCcDesc1","oEmail1","oEmail2","oCcDesc2")
SetPrvt("oCcDesc3","oEmail4","oCcDesc4","oEmail5","oCcDesc5","oCBox12","oCBox13","oCBox14","oCBox15")
SetPrvt("oGrp2","oSay4","oSay5","oSay6","oSay7","oSay8","oSay14","oSay15","oSay35","oCodVara","oEndVara")
SetPrvt("oMunVara","oUfVara","oCep","oCBox17","oGet4","oGrp4","oSay28","oSay29","oSay31","oSay32","oSay30")
SetPrvt("oIdentAut2","oIdentAut3","oIdentAut4","oBtn6","oMGet5","oBtn7","oBtn8")  
SetPrvt("oDescAut11","oDescAut12","oDescAut13","oDescAut14","oDescAut21","oDescAut22","oDescAut23","oDescAut24")
SetPrvt("oDescAut31","oDescAut32","oDescAut33","oDescAut34","oDescAut41","oDescAut42","oDescAut43","oDescAut44","oDescAut51","oDescAut52","oDescAut53","oDescAut53")                                                                                          
SetPrvt("oPlaUsu1","oEmpUsu1","oEmpUsu2","oPlaUsu2","oEmpUsu3","oPlaUsu3","oEmpUsu4","oPlaUsu4","oEmpUsu5")
SetPrvt("oGet13","oGet14","oGet15","oGet16","oGet17","oGrp5","oSay12","oSay16","oSay10","oSay47","oSay48")
SetPrvt("oDescTut","oCBox3","oCBox4","oGet9","oGet10","oGrp6","oSay13","oDescProc","oAsProc","oGrp8")
SetPrvt("oSay21","oSay22","oSay23","oSay17","oDanMora","oVlrmoral","oDanMat","oVlrMat","oVlrProc","oGrp9")
SetPrvt("oSay25","oSay27","oGet18","oTpSent","oSent","oGrp10","oSay11","oSay3","oSay1","oSay2","oSay34")
SetPrvt("oSay39","oSay40","oSay18","oSay9","oSay41","oSay42","oCBox2","oCBox1","oGet1","oGet2","oDtDist")
SetPrvt("oDtRec","oGet11","oGet3","oGrp7","oSay33","oSay36","oSay37","oGet5","oTipoReus1","oNomeReus1","oNomeReus2","oNomeReus3","oNomeReus4")
SetPrvt("oGet7","oCBox6","oGet81","oGet82","oGet83","oGet84","oGet19","oCBox8","oGet201","oGet202","oGet203","oGet204","oGet21","oCBox10","oGrp11","oMGet1","oGrp12")
SetPrvt("oGet64","oGet63","oGet62","oGet61","oGrp13","oBtn1","oBtn2","oDesvaz","oBtn4","oBtn3","oBtn5","oGrp3","oSay19","oSay26","oSay50")
SetPrvt("oCBox7","oMGet2","oGrp14","oSay51","oSay52","oSay53","oCBox9","oCBox11","oCBox18","oCBox5","oCBox19")
SetPrvt("oCBox21","oCBox22","oCBox23","oCBox24","oCBox25","oCBox26","oCBox27","oCBox28","oCBox29","oGrp15")   
SetPrvt("oGet65","oGet66","oGet85","oGet86","oGet205","oGet206","oGet22","oSay44","oCBox10")

 
dbselectarea("PBW")

// fLimVar()

fCargaTema()

If nopc == 3 
   cNumCab:=fProxNum() 
else       
   	 dbselectarea("PBW")
     DbGoto(nReg)
     fMovArqVar()
EndIf             

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
//oDlg1      := MSDialog():New( 013,177,708,1483,"Controle Juridico - Caba410 v1.00",,,.F.,,,,,,.T.,,,.T. ) 
oDlg1      := MSDialog():New( 000,000,770,1300,"Controle Juridico - Caba410 v1.00",,,.F.,,,,,,.T.,,,.T. )
oGrp10     := TGroup():New( 000,000,032,492,"Identificação do Processo",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay11     := TSay():New( 008,204,{||"Tipo Autor "},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay3      := TSay():New( 008,260,{||"Tipo Processo "},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay1      := TSay():New( 008,056,{||"Num. Processo "},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay2      := TSay():New( 008,004,{||"Num. Caberj"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay34     := TSay():New( 004,344,{||"Distribuição"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay38     := TSay():New( 003,388,{||"Recebimento"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay39     := TSay():New( 009,419,{||"Hora"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay40     := TSay():New( 009,381,{||"Data"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay18     := TSay():New( 004,448,{||"Arquivamento"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay9      := TSay():New( 008,141,{||"Num. Compl."},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay41     := TSay():New( 010,342,{||"Data"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay42     := TSay():New( 010,450,{||"Data"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)  
oGet2      := TGet():New( 018,004,{|u| If(PCount()>0,cNumCab:=u,cNumCab)},oGrp10,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Num sequencial do processo na Caberj / Integral",,,.F.,.F.,,.F.,.F.,"","cNumCab",,)
oGet1      := TGet():New( 018,054,{|u| If(PCount()>0,cNumproc:=u,cNumproc)},oGrp10,076,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.F.,.F.,"","cNumproc",,)
oGet3      := TGet():New( 018,139,{|u| If(PCount()>0,(cNumComPr:=u,fValComp()),cNumComPr)},oGrp10,057,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.F.,.F.,"","cNumComPr",,)
oGet3:bLostFocus:={||fValComp()} 

/*
private cUsu410J  := trim(GetMv("MV_USRJUR"))                                          
private cUsu410F  := trim(GetMv("MV_USRFIN"))  
private cUsu410R  := trim(GetMv("MV_USRREG"))  
*/
if ( __cUserID $ AllTrim(cUsu410J) )
	oCBox2     := TComboBox():New( 018,204,{|u| If(PCount()>0,(nTpAutor:=u,fMConsAut(nTpAutor)),nTpAutor)}         ,{" ","Beneficiario","RDA","Colaborador","Reclamante","INSTITUCIONAL","Outros","Proc.ANS"}             ,052,010,oGrp10,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpAutor )
ElseIf ( __cUserID $ AllTrim(cUsu410R) )
	oCBox2     := TComboBox():New( 018,204,{|u| If(PCount()>0,(nTpAutor:=u,fMConsAut(nTpAutor)),nTpAutor)}         ,{" ","Prestador ","Beneficiario","Reclamante","Outros"}                                               ,052,010,oGrp10,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpAutor )
else
	oCBox2     := TComboBox():New( 018,204,{|u| If(PCount()>0,(nTpAutor:=u,fMConsAut(nTpAutor)),nTpAutor)}         ,{" ","Beneficiario","RDA","Colaborador","Reclamante","INSTITUCIONAL","Outros","Proc.ANS"}             ,052,010,oGrp10,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpAutor )
EndIf

if ( __cUserID $ AllTrim(cUsu410J) )
	oCBox1     := TComboBox():New( 018,260,{|u| If(PCount()>0,nTpProc:=u,nTpProc)},{" ","ALERJ", "ANS NIP - Assistencial", "ANS NIP - Não Assistencial", "ANS Auto Infração","ANS Multa" ,"ANS Decisão de Multa","DECON","MINISTERIO PUBLICO","PROCESSO CIVEL","PROCESSO CRIMINAL","PROCESSO TRABALHISTA","PROCESSO TRIBUTARIO","PROCON","RECEITA FEDERAL","ACAO ANULATORIA","EXECUCAO FISCAL","1-PROCESSO INTERNO","OUTROS"},080,010,oGrp10,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpProc )
ElseIf ( __cUserID $ AllTrim(cUsu410R) )
	oCBox1     := TComboBox():New( 018,260,{|u| If(PCount()>0,nTpProc:=u,nTpProc)},{" ","PAP", "ANS NIP - Assistencial", "ANS NIP - Não Assistencial", "ANS Auto Infração","ANS Multa" ,"Representacao","Revisao ADM","OUTROS"},080,010,oGrp10,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpProc )
ElseIf ( __cUserID $ AllTrim(cUsu410F) )
	oCBox1     := TComboBox():New( 018,260,{|u| If(PCount()>0,nTpProc:=u,nTpProc)},{"2-PROCESSO INTERNO"},080,010,oGrp10,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpProc )
Else
	oCBox1     := TComboBox():New( 018,260,{|u| If(PCount()>0,nTpProc:=u,nTpProc)},{" ","ALERJ","PAP", "ANS NIP - Assistencial", "ANS NIP - Não Assistencial", "ANS Auto Infração","ANS Multa" ,"ANS Decisão de Multa","DECON","MINISTERIO PUBLICO","PROCESSO CIVEL","PROCESSO CRIMINAL","PROCESSO TRABALHISTA","PROCESSO TRIBUTARIO","PROCON","RECEITA FEDERAL","ACAO ANULATORIA","EXECUCAO FISCAL","1-PROCESSO INTERNO","Representacao","Revisao ADM","OUTROS"},080,010,oGrp10,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpProc )
EndIF

oDtDist    := TGet():New( 018,344,{|u| If(PCount()>0,dDtDist:=u,dDtDist)},oGrp10,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtDist",,)
oDtRec     := TGet():New( 018,381,{|u| If(PCount()>0,dDtRec:=u,dDtRec)},oGrp10,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtRec",,)

oHoraRec   := TGet():New( 018,420,{|u| If(PCount()>0,(cHoraRec:=u,fValHora(cHoraRec ,'oHoraRec')),cHoraRec)},oGrp10,016,008,'@E 99:99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cHoraRec",,)
if lCritHora
	oHoraRec:setfocus()
endIf

oGet11     := TGet():New( 018,448,{|u| If(PCount()>0,dDtArq:=u,dDtArq)},oGrp10,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtArq",,)

oGrp1      := TGroup():New( 033,324,104,492,"C.Custos",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oCC1       := TGet():New( 040,327,{|u| If(PCount()>0,(cCC1:=u,fConsulCC(cCC1,1),oCC2:refresh()),cCC1)},oGrp1,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.," ",,,.F.,.T.,,.F.,.F.,"CTTJUR","cCC1",,)
oCcDesc1   := TGet():New( 041,360,{|u| If(PCount()>0,cCcDesc1:=u,cCcDesc1)},oGrp1,068,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCcDesc1",,)
oEmail1    := TCheckBox():New( 042,430,"Email ?",{|u| If(PCount()>0,lEmail1:=u,lEmail1)},oGrp1,026,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox12    := TCheckBox():New( 041,459,"Origem",{|u| If(PCount()>0,lOrigem1:=u,lOrigem1)},oGrp1,029,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCC2       := TGet():New( 053,327,{|u| If(PCount()>0,(cCC2:=u,fConsulCC(cCC2,2),oCC2:refresh()),cCC2)},oGrp1,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.," ",,,.F.,.T.,,.F.,.F.,"CTTJUR","cCC2",,)
oCcDesc2   := TGet():New( 054,360,{|u| If(PCount()>0,cCcDesc2:=u,cCcDesc2)},oGrp1,068,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCcDesc2",,)
oEmail2    := TCheckBox():New( 055,430,"Email ?",{|u| If(PCount()>0,lEmail2:=u,lEmail2)},oGrp1,026,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox13    := TCheckBox():New( 055,460,"Origem",{|u| If(PCount()>0,lOrigem2:=u,lOrigem2)},oGrp1,029,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCC3       := TGet():New( 066,327,{|u| If(PCount()>0,(cCC3:=u,fConsulCC(cCC3,3),oCC3:refresh()),cCC3)},oGrp1,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.," ",,,.F.,.F.,,.F.,.F.,"CTTJUR","cCC3",,)
oCcDesc3   := TGet():New( 067,360,{|u| If(PCount()>0,cCcDesc3:=u,cCcDesc3)},oGrp1,068,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCcDesc3",,)
oEmail3    := TCheckBox():New( 069,430,"Email ?",{|u| If(PCount()>0,lEmail3:=u,lEmail3)},oGrp1,026,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox14    := TCheckBox():New( 069,460,"Origem",{|u| If(PCount()>0,lOrigem3:=u,lOrigem3)},oGrp1,029,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCC4       := TGet():New( 079,327,{|u| If(PCount()>0,(cCC4:=u,fConsulCC(cCC4,4),oCC4:refresh()),cCC4)},oGrp1,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.," ",,,.F.,.F.,,.F.,.F.,"CTTJUR","cCC4",,)
oCcDesc4   := TGet():New( 080,360,{|u| If(PCount()>0,cCcDesc4:=u,cCcDesc4)},oGrp1,068,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCcDesc4",,)
oEmail4    := TCheckBox():New( 082,430,"Email ?",{|u| If(PCount()>0,lEmail4:=u,lEmail4)},oGrp1,026,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox15    := TCheckBox():New( 082,460,"Origem",{|u| If(PCount()>0,lOrigem4:=u,lOrigem4)},oGrp1,029,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCC5       := TGet():New( 092,327,{|u| If(PCount()>0,(cCC5:=u,fConsulCC(cCC5,5),oCC5:refresh()),cCC5)},oGrp1,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.," ",,,.F.,.F.,,.F.,.F.,"CTTJUR","cCC5",,)
oCcDesc5   := TGet():New( 093,360,{|u| If(PCount()>0,cCcDesc5:=u,cCcDesc5)},oGrp1,068,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCcDesc5",,)
oEmail5    := TCheckBox():New( 094,430,"Email ?",{|u| If(PCount()>0,lEmail5:=u,lEmail5)},oGrp1,028,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox16    := TCheckBox():New( 094,460,"Origem",{|u| If(PCount()>0,lOrigem5:=u,lOrigem5)},oGrp1,029,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGrp2      := TGroup():New( 104,000,136,492,"Vara / Juizado",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay4      := TSay():New( 112,004,{||"Código "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay5      := TSay():New( 113,109,{||"Endereço "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay6      := TSay():New( 112,264,{||"Bairro "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay7      := TSay():New( 112,332,{||"Município"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay8      := TSay():New( 112,404,{||"UF"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,012,008)
oSay14     := TSay():New( 112,444,{||"Cep"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay15     := TSay():New( 113,041,{||"Vara/Juizado"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,035,008)
oSay35     := TSay():New( 108,240,{||"Num."},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oCodVara   := TGet():New( 120,004,{|u| If(PCount()>0,cCodVara:=u,cCodVara)},oGrp2,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCodVara",,)
oEndVara   := TGet():New( 120,108,{|u| If(PCount()>0,cEndVara:=u,cEndVara)},oGrp2,128,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cEndVara",,)
oBairVara  := TGet():New( 120,264,{|u| If(PCount()>0,cBairVara:=u,cBairVara)},oGrp2,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cBairVara",,)
oMunVara   := TGet():New( 120,332,{|u| If(PCount()>0,cMunVara:=u,cMunVara)},oGrp2,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cMunVara",,)
oUfVara    := TGet():New( 120,400,{|u| If(PCount()>0,cUfVara:=u,cUfVara)},oGrp2,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cUfVara",,)
oCep       := TGet():New( 120,444,{|u| If(PCount()>0,(cCep:=u,fConsulCEP(cCep)),cCep)},oGrp2,040,008,'@E !!!!!-!!!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCep",,)
oCBox17    := TComboBox():New( 120,040,{|u| If(PCount()>0,nIdentVara:=u,nIdentVara)},{" ","Vara ","Juizado","outros"},056,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nIdentVara )
oGet4      := TGet():New( 120,240,{|u| If(PCount()>0,cNumvara:=u,cNumvara)},oGrp2,020,008,'@E 9,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNumvara",,)
oGrp4      := TGroup():New( 204,000,284,493,"Autor(es)",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay28     := TSay():New( 212,005,{||"Identificação"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay29     := TSay():New( 212,080,{||"Razão Social / Nome "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,092,008)
oSay31     := TSay():New( 212,252,{||"Plano  - Atual"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oSay32     := TSay():New( 212,348,{||"Plano - Original"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,012)
oSay30     := TSay():New( 212,452,{||"Cod. F/C/M"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)

oDescAut11 := TGet():New( 220,079,{|u| If(PCount()>0,cDescAut1 :=u                        ,cDescAut1)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,""      ,"cDescAut1",,)
oDescAut12 := TGet():New( 220,079,{|u| If(PCount()>0,(cDescAut1:=u,fFConsAut(cDescAut1,1)),cDescAut1)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BA1JU1","cDescAut1",,)
oDescAut13 := TGet():New( 220,079,{|u| If(PCount()>0,(cDescAut1:=u,fFConsAut(cDescAut1,1)),cDescAut1)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BAUJUR","cDescAut1",,)
oDescAut14 := TGet():New( 220,079,{|u| If(PCount()>0,(cDescAut1:=u,fFConsAut(cDescAut1,1)),cDescAut1)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SRAJUR","cDescAut1",,)

oDescAut21 := TGet():New( 233,079,{|u| If(PCount()>0,cDescAut2:=u                         ,cDescAut2)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,""      ,"cDescAut2",,)
oDescAut22 := TGet():New( 233,079,{|u| If(PCount()>0,(cDescAut2:=u,fFConsAut(cDescAut2,2)),cDescAut2)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BA1JU1","cDescAut2",,)
oDescAut23 := TGet():New( 233,079,{|u| If(PCount()>0,(cDescAut2:=u,fFConsAut(cDescAut2,2)),cDescAut2)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BAUJUR","cDescAut2",,)
oDescAut24 := TGet():New( 233,079,{|u| If(PCount()>0,(cDescAut2:=u,fFConsAut(cDescAut2,2)),cDescAut2)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SRAJUR","cDescAut2",,)

oPlaUsu1   := TGet():New( 220,253,{|u| If(PCount()>0,cPlaUsuAt1:=u,cPlaUsuAt1)},oGrp4,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPlaUsuAt1",,)
oPlaUsu2   := TGet():New( 233,253,{|u| If(PCount()>0,cPlaUsuAt2:=u,cPlaUsuAt2)},oGrp4,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPlaUsuAt2",,)
oPlaUsu3   := TGet():New( 246,253,{|u| If(PCount()>0,cPlaUsuAt3:=u,cPlaUsuAt3)},oGrp4,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPlaUsuAt3",,)
oPlaUsu4   := TGet():New( 257,253,{|u| If(PCount()>0,cPlaUsuAt4:=u,cPlaUsuAt4)},oGrp4,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPlaUsuAt4",,)
oPlaUsu5   := TGet():New( 269,253,{|u| If(PCount()>0,cPlaUsuAt5:=u,cPlaUsuAt5)},oGrp4,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPlaUsuAt5",,)

oEmpUsu1   := TGet():New( 220,349,{|u| If(PCount()>0,cPlaUsuOr1:=u,cPlaUsuOr1)},oGrp4,091,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPlaUsuOr1",,)
oEmpUsu2   := TGet():New( 233,349,{|u| If(PCount()>0,cPlaUsuOr2:=u,cPlaUsuOr2)},oGrp4,091,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPlaUsuOr2",,)
oEmpUsu3   := TGet():New( 246,349,{|u| If(PCount()>0,cPlaUsuOr3:=u,cPlaUsuOr3)},oGrp4,091,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPlaUsuOr3",,)
oEmpUsu4   := TGet():New( 257,349,{|u| If(PCount()>0,cPlaUsuOr4:=u,cPlaUsuOr4)},oGrp4,091,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPlaUsuOr4",,)
oEmpUsu5   := TGet():New( 269,349,{|u| If(PCount()>0,cPlaUsuOr5:=u,cPlaUsuOr5)},oGrp4,091,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPlaUsuOr5",,)

oIdentAut1 := TGet():New( 220,005,{|u| If(PCount()>0,cIdentAut1:=u,cIdentAut1)},oGrp4,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cIdentAut1",,)
oIdentAut2 := TGet():New( 233,005,{|u| If(PCount()>0,cIdentAut2:=u,cIdentAut2)},oGrp4,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cIdentAut2",,)
oIdentAut3 := TGet():New( 246,005,{|u| If(PCount()>0,cIdentAut3:=u,cIdentAut3)},oGrp4,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cIdentAut3",,)
oIdentAut4 := TGet():New( 257,005,{|u| If(PCount()>0,cIdentAut4:=u,cIdentAut4)},oGrp4,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cIdentAut4",,)
oIdentAut5 := TGet():New( 269,005,{|u| If(PCount()>0,cIdentAut5:=u,cIdentAut5)},oGrp4,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cIdentAut5",,)

oDescAut31 := TGet():New( 246,079,{|u| If(PCount()>0, cDescAut3:=u                        ,cDescAut3)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,""      ,"cDescAut3",,)
oDescAut32 := TGet():New( 246,079,{|u| If(PCount()>0,(cDescAut3:=u,fFConsAut(cDescAut3,3)),cDescAut3)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BA1JU1","cDescAut3",,)
oDescAut33 := TGet():New( 246,079,{|u| If(PCount()>0,(cDescAut3:=u,fFConsAut(cDescAut3,3)),cDescAut3)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BAUJUR","cDescAut3",,)
oDescAut34 := TGet():New( 246,079,{|u| If(PCount()>0,(cDescAut3:=u,fFConsAut(cDescAut3,3)),cDescAut3)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SRAJUR","cDescAut3",,)

oGet13     := TGet():New( 220,452,{|u| If(PCount()>0,cForCli1:=u,cForCli1)},oGrp4,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cForCli1",,)
oGet14     := TGet():New( 232,452,{|u| If(PCount()>0,cForCli2:=u,cForCli2)},oGrp4,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cForCli2",,)
oGet15     := TGet():New( 244,452,{|u| If(PCount()>0,cForCli3:=u,cForCli3)},oGrp4,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cForCli3",,)
oGet16     := TGet():New( 256,452,{|u| If(PCount()>0,cForCli4:=u,cForCli4)},oGrp4,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cForCli4",,)
oGet17     := TGet():New( 268,452,{|u| If(PCount()>0,cForCli5:=u,cForCli5)},oGrp4,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cForCli5",,)

oDescAut41  := TGet():New( 257,079,{|u| If(PCount()>0,cDescAut4:= u                        ,cDescAut4)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,""      ,"cDescAut4",,)
oDescAut42  := TGet():New( 257,079,{|u| If(PCount()>0,(cDescAut4:=u,fFConsAut(cDescAut4,4)),cDescAut4)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BA1JU1","cDescAut4",,)
oDescAut43  := TGet():New( 257,079,{|u| If(PCount()>0,(cDescAut4:=u,fFConsAut(cDescAut4,4)),cDescAut4)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BAUJUR","cDescAut4",,)
oDescAut44  := TGet():New( 257,079,{|u| If(PCount()>0,(cDescAut4:=u,fFConsAut(cDescAut4,4)),cDescAut4)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SRAJUR","cDescAut4",,)

oDescAut51  := TGet():New( 269,079,{|u| If(PCount()>0,cDescAut5:=u                         ,cDescAut5)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,""      ,"cDescAut5",,)
oDescAut52  := TGet():New( 269,079,{|u| If(PCount()>0,(cDescAut5:=u,fFConsAut(cDescAut5,5)),cDescAut4)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BA1JU1","cDescAut5",,)
oDescAut53  := TGet():New( 269,079,{|u| If(PCount()>0,(cDescAut5:=u,fFConsAut(cDescAut5,5)),cDescAut4)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BAUJUR","cDescAut5",,)
oDescAut54  := TGet():New( 269,079,{|u| If(PCount()>0,(cDescAut5:=u,fFConsAut(cDescAut5,5)),cDescAut4)},oGrp4,157,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SRAJUR","cDescAut5",,)


oGrp5      := TGroup():New( 136,232,204,492,"Inf.Tutela ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay12     := TSay():New( 144,236,{||"Tutela :"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay16     := TSay():New( 144,270,{||"Tutela Revogada"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,046,008)
oSay10     := TSay():New( 140,324,{||"Descrição"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay47     := TSay():New( 168,256,{||"Cumprimento"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay48     := TSay():New( 176,292,{||"Hora"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay49     := TSay():New( 176,240,{||"Data"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oDescTut   := TMultiGet():New( 148,324,{|u| If(PCount()>0,cDescTut:=u,cDescTut)},oGrp5,164,048,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

oCBox3     := TComboBox():New( 153,236,{|u| If(PCount()>0,(nComTut:=u,ftutela(nComTut)),nComTut)},{"Nao","Sim"},032,010,oGrp5,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nComTut )
//oCBox3:bLostFocus:={||ftcmpbloq()} 
oCBox4     := TComboBox():New( 153,272,{|u| If(PCount()>0,nSusTut:=u,nSusTut)},{"Nao","Sim",},036,010,oGrp5,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nSusTut )
//oCBox4:bLostFocus:={||ftcmpbloq()} 
oGet9      := TGet():New( 184,292,{|u| If(PCount()>0,cHoraCump:=u,cHoraCump)},oGrp5,016,008,'@E 99:99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cHoraCump",,)
oGet10     := TGet():New( 184,240,{|u| If(PCount()>0,dDtCumpTut:=u,dDtCumpTut)},oGrp5,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtCumpTut",,)

oGrp6      := TGroup():New( 033,000,104,212,"Descrição Processo ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay13     := TSay():New( 041,005,{||"Assunto :"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,023,008)

oDescProc  := TMultiGet():New( 053,004,{|u| If(PCount()>0,cDescProc:=u,cDescProc)},oGrp6,204,044,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

//oAsProc    := TComboBox():New( 041,029,{|u| If(PCount()>0,nAsProc:=u,nAsProc)},{" ","ARTIGO 30 / 31	","AUTORIZACAO DE OPME","BOLETO - CARTEIRA - REGULAMENTO	","CARENCIA	","COBERTURA - CIRURGIA	","COBERTURA - EXAME	","COBERTURA - INTERNACAO","COBRANCA - INDEVIDA","COBRANCA - REDE CREDENCIADA	","AUTORIZACAO DE PROCEDIMENTO FORA DE PRAZO","DESCREDENCIAMENTO	","ERRO MEDICO	","EXCLUSAO DE PLANO	","COBERTURA - HOMECARE","INADIMPLENCIA	","INCLUSAO DE PLANO	","COBERTURA - MEDICAMENTO","MIGRACAO DE PLANO	","REAJUSTE	","REDE CREDENCIADA	","REEMBOLSO	","REPASSE DE CREDITO	","RECISÃO CONTRATUAL	","REPASSE CUSTO MED.","OUTROS	","COBRANCA - EMP.CLIENTE  ","COBRANCA - ADMINISTRADORA"},179,010,oGrp6,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nAsProc )
if ( __cUserID $ AllTrim(cUsu410J) )
	oAsProc    := TComboBox():New( 041,029,{|u| If(PCount()>0,nAsProc:=u,nAsProc)},{" ","ARTIGO 30 / 31	","AUTORIZACAO DE OPME","AUTORIZACAO DE PROCEDIMENTO FORA DE PRAZO","BOLETO - CARTEIRA - REGULAMENTO	","CARENCIA	","COBERTURA CONSULTA","COBERTURA - CIRURGIA	","COBERTURA - EXAME	","COBERTURA - HOMECARE","COBERTURA - INTERNACAO","COBERTURA - MEDICAMENTO","COBRANCA - ADMINISTRADORA","COBRANCA - EMP.CLIENTE  ","COBRANCA - INDEVIDA","COBRANCA - REDE CREDENCIADA	","DESCREDENCIAMENTO	","ERRO MEDICO	","EXCLUSAO DE PLANO	","INADIMPLENCIA	","INCLUSAO DE PLANO	","MIGRACAO DE PLANO	","REAJUSTE	","REDE CREDENCIADA	","REEMBOLSO	","REPASSE DE CREDITO	","REPASSE CUSTO MED.","RECISÃO CONTRATUAL	","PORTABILIDADE","ADESÃO AO PLANO","OUTROS	"},179,010,oGrp6,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nAsProc )
Elseif ( __cUserID $ AllTrim(cUsu410R) )
	oAsProc    := TComboBox():New( 041,029,{|u| If(PCount()>0,nAsProc:=u,nAsProc)},{" ","ARTIGO 30 / 31	","AUTORIZACAO DE OPME","AUTORIZACAO DE PROCEDIMENTO FORA DE PRAZO","BOLETO - CARTEIRA - REGULAMENTO	","CARENCIA	","COBERTURA CONSULTA","COBERTURA - CIRURGIA	","COBERTURA - EXAME	","COBERTURA - HOMECARE","COBERTURA - INTERNACAO","COBERTURA - MEDICAMENTO","COBRANCA - INDEVIDA","DESCREDENCIAMENTO	","EXCLUSAO DE PLANO	","INADIMPLENCIA	","INCLUSAO DE PLANO	","MIGRACAO DE PLANO	","REAJUSTE	","REDE CREDENCIADA	","REEMBOLSO	","RESCISÃO CONTRATUAL","PORTABILIDADE","ADESÃO AO PLANO","OUTROS	"},179,010,oGrp6,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nAsProc )
else
	oAsProc    := TComboBox():New( 041,029,{|u| If(PCount()>0,nAsProc:=u,nAsProc)},{" ","ARTIGO 30 / 31	","AUTORIZACAO DE OPME","AUTORIZACAO DE PROCEDIMENTO FORA DE PRAZO","BOLETO - CARTEIRA - REGULAMENTO	","CARENCIA	","COBERTURA CONSULTA","COBERTURA - CIRURGIA	","COBERTURA - EXAME	","COBERTURA - HOMECARE","COBERTURA - INTERNACAO","COBERTURA - MEDICAMENTO","COBRANCA - ADMINISTRADORA","COBRANCA - EMP.CLIENTE  ","COBRANCA - INDEVIDA","COBRANCA - REDE CREDENCIADA	","DESCREDENCIAMENTO	","ERRO MEDICO	","EXCLUSAO DE PLANO	","INADIMPLENCIA	","INCLUSAO DE PLANO	","MIGRACAO DE PLANO	","REAJUSTE	","REDE CREDENCIADA	","REEMBOLSO	","REPASSE DE CREDITO	","REPASSE CUSTO MED.","RECISÃO CONTRATUAL	","PORTABILIDADE","ADESÃO AO PLANO","OUTROS	"},179,010,oGrp6,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nAsProc )
EndIf

oGrp8      := TGroup():New( 033,216,105,320,"Danos Moral / Danos Material ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay20     := TSay():New( 041,222,{||"Danos Morais "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,038,008)
oSay21     := TSay():New( 061,220,{||"Vlr Dano Moral"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay22     := TSay():New( 061,273,{||"Vlr Dano Material"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay23     := TSay():New( 041,273,{||"Danos Material "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,038,008)
oSay17     := TSay():New( 082,241,{||"Valor da Causa "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
oDanMora   := TComboBox():New( 049,217,{|u| If(PCount()>0,nDanMora:=u,nDanMora)},{"Nao","Sim"},036,010,oGrp8,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nDanMora )
oVlrmoral  := TGet():New( 069,220,{|u| If(PCount()>0,(nVlrmoral:=u,fvlrcausa(),oVlrProc :refresh()),nVlrmoral)},oGrp8,044,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrmoral",,)

oDanMat    := TComboBox():New( 049,273,{|u| If(PCount()>0,nDanMat:=u,nDanMat)},{"Nao","Sim"},036,010,oGrp8,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nDanMat )
oVlrMat    := TGet():New( 069,273,{|u| If(PCount()>0,(nVlrMat:=u,fvlrcausa(),oVlrProc :refresh()), nVlrMat)},oGrp8,043,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrMat",,)

oVlrProc   := TGet():New( 090,240,{|u| If(PCount()>0,nVlrProc:=u,nVlrProc)},oGrp8,044,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.F.,.F.,"","nVlrProc",,)

oGrp7      := TGroup():New( 136,000,204,228,"Réus",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay33     := TSay():New( 144,056,{||"Cpf/Cnpj/Identif."},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay36     := TSay():New( 144,004,{||"Tipo"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay37     := TSay():New( 144,112,{||"Razão Social / Nome "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
if ( __cUserID $ AllTrim(cUsu410J) )
	oTipoReus1 := TComboBox():New( 152,004,{|u| If(PCount()>0,(nTipoReus1:=u,fMConsReus(nTipoReus1,1)),nTipoReus1)},{"","CABERJ","INTEGRAL","RDA","FORNECEDOR","BENEFICIARIO","EMP.CLIENTE", "ADM.BENEFICIOS","OUTROS"},048,010,oGrp7,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTipoReus1 )
elseif ( __cUserID $ AllTrim(cUsu410R) )
	oTipoReus1 := TComboBox():New( 152,004,{|u| If(PCount()>0,(nTipoReus1:=u,fMConsReus(nTipoReus1,1)),nTipoReus1)},{"","CABERJ","INTEGRAL","OUTROS"},048,010,oGrp7,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTipoReus1 )
else
	oTipoReus1 := TComboBox():New( 152,004,{|u| If(PCount()>0,(nTipoReus1:=u,fMConsReus(nTipoReus1,1)),nTipoReus1)},{"","CABERJ","INTEGRAL","RDA","FORNECEDOR","BENEFICIARIO","EMP.CLIENTE", "ADM.BENEFICIOS","OUTROS"},048,010,oGrp7,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTipoReus1 )
EndIf

oGet5      := TGet():New( 152,056,{|u| If(PCount()>0,cCpfCnpj1:=u,cCpfCnpj1)},oGrp7,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCpfCnpj1",,)

// -é necessario para ter mais de uma consulta F3 para o mesmo caso
oNomeReus1  := TGet():New( 152,112,{|u| If(PCount()>0,cNomeReus1:=u,cNomeReus1)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomeReus1",,)
oNomeReus2  := TGet():New( 152,112,{|u| If(PCount()>0,(cNomeReus1:=u,fConsulReu("RDA",cNomeReus1,1)),cNomeReus1)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BAUJUR","cNomeReus1",,)
oNomeReus3  := TGet():New( 152,112,{|u| If(PCount()>0,(cNomeReus1:=u,fConsulReu("FORNECEDOR",cNomeReus1,1)),cNomeReus1)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2JUR","cNomeReus1",,)
oNomeReus4  := TGet():New( 152,112,{|u| If(PCount()>0,(cNomeReus1:=u,fConsulReu("BENEFICIARIO",cNomeReus1,1)),cNomeReus1)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BA1JUR","cNomeReus1",,)

oNomeReus5  := TGet():New( 152,112,{|u| If(PCount()>0,(cNomeReus1:=u,fConsulReu("EMP.CLIENTE",cNomeReus1,1)),cNomeReus1)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1JU1","cNomeReus1",,)
oNomeReus6  := TGet():New( 152,112,{|u| If(PCount()>0,(cNomeReus1:=u,fConsulReu("ADM.BENEFICIOS",cNomeReus1,1)),cNomeReus1)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1JU1","cNomeReus1",,)
if ( __cUserID $ AllTrim(cUsu410J) )
	oCBox6     := TComboBox():New( 165,004,{|u| If(PCount()>0,(nTipoReus2:=u,fMConsReus(nTipoReus2,2)),nTipoReus2)},{"","CABERJ","INTEGRAL","RDA","FORNECEDOR","BENEFICIARIO","EMP.CLIENTE", "ADM.BENEFICIOS","OUTROS"},048,010,oGrp7,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTipoReus2 )
Elseif ( __cUserID $ AllTrim(cUsu410R) )
	oCBox6     := TComboBox():New( 165,004,{|u| If(PCount()>0,(nTipoReus2:=u,fMConsReus(nTipoReus2,2)),nTipoReus2)},{"","CABERJ","INTEGRAL","OUTROS"},048,010,oGrp7,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTipoReus2 )
else
	oCBox6     := TComboBox():New( 165,004,{|u| If(PCount()>0,(nTipoReus2:=u,fMConsReus(nTipoReus2,2)),nTipoReus2)},{"","CABERJ","INTEGRAL","RDA","FORNECEDOR","BENEFICIARIO","EMP.CLIENTE", "ADM.BENEFICIOS","OUTROS"},048,010,oGrp7,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTipoReus2 )
EndIf

oGet7      := TGet():New( 165,056,{|u| If(PCount()>0,cCpfCnpj2:=u,cCpfCnpj2)},oGrp7,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCpfCnpj2",,)

oGet61     := TGet():New( 165,112,{|u| If(PCount()>0,cNomeReus2:=u,cNomeReus2)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomeReus2",,)
oGet62     := TGet():New( 165,112,{|u| If(PCount()>0,(cNomeReus2:=u,fConsulReu("RDA",cNomeReus2,2)),cNomeReus2)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BAUJUR","cNomeReus2",,)
oGet63     := TGet():New( 165,112,{|u| If(PCount()>0,(cNomeReus2:=u,fConsulReu("FORNECEDOR",cNomeReus2,2)),cNomeReus2)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2JUR","cNomeReus2",,)
oGet64     := TGet():New( 165,112,{|u| If(PCount()>0,(cNomeReus2:=u,fConsulReu("BENEFICIARIO",cNomeReus2,2)),cNomeReus2)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BA1JUR","cNomeReus2",,)

//oGet65     := TGet():New( 165,112,{|u| If(PCount()>0,(cNomeReus2:=u,fConsulReu("EMP.CLIENTE",cNomeReus2,2)),cNomeReus2)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BG9JUR","cNomeReus2",,)  
//oGet66     := TGet():New( 165,112,{|u| If(PCount()>0,(cNomeReus2:=u,fConsulReu("ADM.BENEFICIOS",cNomeReus2,2)),cNomeReus2)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BG9JUR","cNomeReus2",,)

oGet65     := TGet():New( 165,112,{|u| If(PCount()>0,(cNomeReus2:=u,fConsulReu("EMP.CLIENTE",cNomeReus2,2)),cNomeReus2)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1JU1","cNomeReus2",,)
oGet66     := TGet():New( 165,112,{|u| If(PCount()>0,(cNomeReus2:=u,fConsulReu("ADM.BENEFICIOS",cNomeReus2,2)),cNomeReus2)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1JU1","cNomeReus2",,)


oCBox8     := TComboBox():New( 177,004,{|u| If(PCount()>0,(nTipoReus3:=u,fMConsReus(nTipoReus3,3)),nTipoReus3)},{"","RDA","FORNECEDOR","BENEFICIARIO","EMP.CLIENTE", "ADM.BENEFICIOS","OUTROS"},048,010,oGrp7,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTipoReus3 )
oGet19     := TGet():New( 177,056,{|u| If(PCount()>0,cCpfCnpj3:=u,cCpfCnpj3)},oGrp7,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCpfCnpj3",,)

oGet81     := TGet():New( 177,112,{|u| If(PCount()>0, cNomeReus3:=u,cNomeReus3)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomeReus3",,)
oGet82     := TGet():New( 177,112,{|u| If(PCount()>0,(cNomeReus3:=u,fConsulReu("RDA",cNomeReus3,3)),cNomeReus3)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BAUJUR","cNomeReus3",,)
oGet83     := TGet():New( 177,112,{|u| If(PCount()>0,(cNomeReus3:=u,fConsulReu("FORNECEDOR",cNomeReus3,3)),cNomeReus3)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2JUR","cNomeReus3",,)
oGet84     := TGet():New( 177,112,{|u| If(PCount()>0,(cNomeReus3:=u,fConsulReu("BENEFICIARIO",cNomeReus3,3)),cNomeReus3)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BA1JUR","cNomeReus3",,)

oGet85     := TGet():New( 177,112,{|u| If(PCount()>0,(cNomeReus3:=u,fConsulReu("EMP.CLIENTE",cNomeReus3,3)),cNomeReus3)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1JU1","cNomeReus3",,)
oGet86     := TGet():New( 177,112,{|u| If(PCount()>0,(cNomeReus3:=u,fConsulReu("ADM.BENEFICIOS",cNomeReus3,3)),cNomeReus3)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1JU1","cNomeReus3",,)

oCBox10    := TComboBox():New( 189,004,{|u| If(PCount()>0,(nTipoReus4:=u,fMConsReus(nTipoReus4,4)),nTipoReus4)},{"","RDA","FORNECEDOR","BENEFICIARIO","EMP.CLIENTE", "ADM.BENEFICIOS","OUTROS"},048,010,oGrp7,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTipoReus4 )
oGet21     := TGet():New( 189,056,{|u| If(PCount()>0,cCpfCnpj4:=u,cCpfCnpj4)},oGrp7,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCpfCnpj4",,)

oGet201    := TGet():New( 189,112,{|u| If(PCount()>0,cNomeReus4:=u,cNomeReus4)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomeReus4",,)
oGet202    := TGet():New( 189,112,{|u| If(PCount()>0,(cNomeReus4:=u,fConsulReu("RDA",cNomeReus4,4)),cNomeReus4)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BAUJUR","cNomeReus4",,)
oGet203    := TGet():New( 189,112,{|u| If(PCount()>0,(cNomeReus4:=u,fConsulReu("FORNECEDOR",cNomeReus4,4)),cNomeReus4)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2JUR","cNomeReus4",,)
oGet204    := TGet():New( 189,112,{|u| If(PCount()>0,(cNomeReus4:=u,fConsulReu("BENEFICIARIO",cNomeReus4,4)),cNomeReus4)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BA1JUR","cNomeReus4",,)

oGet205    := TGet():New( 189,112,{|u| If(PCount()>0,(cNomeReus4:=u,fConsulReu("EMP.CLIENTE",cNomeReus4,4)),cNomeReus4)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1JU1","cNomeReus4",,)
oGet206    := TGet():New( 189,112,{|u| If(PCount()>0,(cNomeReus4:=u,fConsulReu("ADM.BENEFICIOS",cNomeReus4,4)),cNomeReus4)},oGrp7,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1JU1","cNomeReus4",,)

oGrp11     := TGroup():New( 117,496,192,648,"Ônus da Causa",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 125,500,{|u| If(PCount()>0,cOnuscausa:=u,cOnuscausa)},oGrp11,144,060,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )

oGrp12     := TGroup():New( 196,496,272,648,"Andamento da Ação ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet3     := TMultiGet():New( 204,500,{|u| If(PCount()>0,cAudPraz:=u,cAudPraz)},oGrp12,144,064,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oGrp13     := TGroup():New( 000,496,052,648,"Controles",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
/////////////////

//oBtn1.hint := "Primeira Linha"+#13+"Segunda Linha"+13+ "Terceira Linha"+13+"Quarta Linha"
oBtn1      := TButton():New( 008,500,"Grava",oGrp13,{ ||fgravaReg() },044,012,,,,.T.,,"",,,,.F. )
oBtn5      := TButton():New( 008,548,"And/Aud/Prazos",oGrp13,{||fAndPrz()},044,012,,,,.T.,,"",,,,.F. )
//oBtn6      := TButton():New( 008,596,"Email",oGrp13,{ || fVazEmail() },044,012,,,,.T.,,"",,,,.F. )

oBtn6      := TButton():New( 008,596,"Multas ANS",oGrp13,{ ||fCadMulAns() },044,012,,,,.T.,,"",,,,.F. )

oBtn2      := TButton():New( 022,500,"Deleta",oGrp13,{||fdeletaReg()},044,012,,,,.T.,,"",,,,.F. )
oDesvaz    := TButton():New( 022,548,"Ônus da Causa ",oGrp13,{||fonusCls()},044,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 022,596,"Desdobramentos",oGrp13,{ || fdesdob() },044,012,,,,.T.,,"",,,,.F. )

oBtn7      := TButton():New( 036,500,"Documento",oGrp13,{||fBcoConhec()},044,012,,,,.T.,,"",,,,.F. )
//oBtn8      := TButton():New( 036,548,"Nova Implem",oGrp13,,044,012,,,,.T.,,"",,,,.F. )
oBtn8      := TButton():New( 036,548,"Fluig" ,oGrp13,{||fIDFluig()} ,044,012,,,,.T.,,"",,,,.F. )
oBtn4      := TButton():New( 036,596,"Sair",oGrp13,{||oDlg1:End()},044,012,,,,.T.,,"",,,,.F. )

/*oBtn4      := TButton():New( 036,500,"Sair",oGrp13,{||oDlg1:End()},092,012,,,,.T.,,"",,,,.F. )
oBtn7      := TButton():New( 036,596,"Documento",oGrp13,{ || fBcoConhec() },044,012,,,,.T.,,"",,,,.F. )
*/
/////////////////

oGrp14     := TGroup():New( 276,496,344,648,"Senhas",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
//oMGet5     := TMultiGet():New( 284,500,{|u| If(PCount()>0,cSenha1:=u,cSenha1)},oGrp14,144,056,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )

oGrp3      := TGroup():New( 284,000,344,252,"Sentença 1 Instância",oDlg1,CLR_RED,CLR_WHITE,.T.,.F. )
oSay19     := TSay():New( 292,004,{||"Dt Sentença"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay26     := TSay():New( 316,004,{||"Tipo Sentença"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay50     := TSay():New( 288,056,{||"Descrição da Sentença / Acordo "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,148,008)
oGet12     := TGet():New( 302,004,{|u| If(PCount()>0,dDtSent1:=u,dDtSent1)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtSent1",,)
//oGet12:bLostFocus:={||ftcmpbloq()} 

if ( __cUserID $ AllTrim(cUsu410R) )
	oCBox7     := TComboBox():New( 326,004,{|u| If(PCount()>0,nTpSent1:=u,nTpSent1)},{" "},040,010,oGrp3,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpSent1 )
Else
	oCBox7     := TComboBox():New( 326,004,{|u| If(PCount()>0,nTpSent1:=u,nTpSent1)},{" ","Procedente","Improcedente","Proc Em Part","S/Mérito","Acordo"},040,010,oGrp3,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpSent1 )
EndIF

oMGet2     := TMultiGet():New( 296,048,{|u| If(PCount()>0,cSent1:=u,cSent1)},oGrp3,200,044,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

oGrp9      := TGroup():New( 284,253,344,492,"Decisão 2 instância",oDlg1,CLR_RED,CLR_WHITE,.T.,.F. )
oSay24     := TSay():New( 292,257,{||"Dt Decisão"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay25     := TSay():New( 316,257,{||"Tipo Decisão"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay27     := TSay():New( 288,309,{||"Descrisão da Decisão / Acordo"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,148,008)
oGet18     := TGet():New( 302,257,{|u| If(PCount()>0,dDtsent2:=u,dDtsent2)},oGrp9,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtsent2",,)

if ( __cUserID $ AllTrim(cUsu410R) )
	oTpSent    := TComboBox():New( 326,257,{|u| If(PCount()>0,nTpSent2:=u,nTpSent2)},{" "},040,010,oGrp9,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpSent2 )
Else
	oTpSent    := TComboBox():New( 326,257,{|u| If(PCount()>0,nTpSent2:=u,nTpSent2)},{" ","Procedente","Improcedente","Proc Em Part","S/Mérito","Acordo"},040,010,oGrp9,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpSent2 )
EndIf
oSent      := TMultiGet():New( 296,301,{|u| If(PCount()>0,cSent2:=u,cSent2)},oGrp9,188,044,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

//oMGet5     := TMultiGet():New( 284,500,,oGrp14,144,056,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oGrp15     := TGroup():New( 056,496,116,648,"Desdobramentos",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet4     := TMultiGet():New( 064,500,{|u| If(PCount()>0,cdesdob:=u,cdesdob)},oGrp15,144,048,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )

oGrp16     := TGroup():New( 348,000,384,648,"Tema / Status - ANS",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )

oCBox5     := TComboBox():New( 356,008,{|u| If(PCount()>0,nTema:=u,nTema)},{""},484,010,oGrp16,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTema )
//oCBox5     := TComboBox():New( 356,008,{|u| If(PCount()>0,nTema:=u,nTema)},{"","Produto ou Plano >> Contratos e Regulamentos >> Suspensao e Rescisao Contratuais","Produto ou Plano >> Cobertura >> Rede de Atendimento (rede conveniada)","Produto ou Plano >> Cobertura >> Rol de Procedimentos e Coberturas (geografica e assistencial)","Produto ou Plano >> Cobertura >> Gerenciamento das Acoes de Saude por Parte da Operadora(autorizacoes previas, franquia, co-participacao e outros)","Produto ou Plano >> Cobertura >> Reembolso","Produto ou Plano >> Contratos e Regulamentos >> Itens Obrigatorios e Clausulas Contratuais","Produto ou Plano >> Contratos e Regulamentos >> Inclusão de Dependentes do Consumidor"},484,010,oGrp16,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTema )
oSay43     := TSay():New( 356,494,{||"Status ANS"},oGrp16,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oCBox9     := TComboBox():New( 356,526,{|u| If(PCount()>0,nStatus:=u,nStatus)},{""},072,010,oGrp16,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nStatus )
//oCBox9     := TComboBox():New( 356,526,{|u| If(PCount()>0,nStatus:=u,nStatus)},{aStatusAns},072,010,oGrp16,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nStatus )


oSay44     := TSay():New( 368,494,{||"Escritório"},oGrp16,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)


if ( __cUserID $ AllTrim(cUsu410J) )
	oCBox11      := TComboBox():New( 368,526,{|u| If(PCount()>0,nEAdvog:=u,nEAdvog)},{"Instituicao","Maquieira","FRS","ConsulTrab","Costa e Mancuso"},072,010,oGrp16,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nStatus )
Elseif ( __cUserID $ AllTrim(cUsu410R) )
	oCBox11      := TComboBox():New( 368,526,{|u| If(PCount()>0,nEAdvog:=u,nEAdvog)},{"Instituicao","Costa e Mancuso"},072,010,oGrp16,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nEAdvog )
else
	oCBox11      := TComboBox():New( 368,526,{|u| If(PCount()>0,nEAdvog:=u,nEAdvog)},{"Instituicao","Maquieira","FRS","ConsulTrab","Costa e Mancuso"},072,010,oGrp16,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nEAdvog )
EndIf
//oCBox9     := TComboBox():New( 356,536,{|u| If(PCount()>0,nStatus:=u,nStatus)},{"","INATIVA","NP","RVE","NA","NUCLEO",""},072,010,oGrp16,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nStatus )

oSay45     := TSay():New( 356,600,{||"Vlr Escritorio"},oGrp16,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

oVlrEsc    := TGet():New( 368,600,{|u| If(PCount()>0,nVlrEsc:=u,nVlrEsc)},oGrp8,044,008,'@E 9,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrEsc",,)

//oGet22     := TGet():New( 368,008,{|u| If(PCount()>0,cTemaed:=u,cTemaed)},oGrp16,484,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTemaed",,)
oGet22     := TGet():New( 368,008,{|u| If(PCount()>0,cTemaed:=u,cTemaed)},oGrp16,400,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTemaed",,)
oGet23     := TGet():New( 368,412,{|u| If(PCount()>0,cStatusANS:=u,cStatusANS)},oGrp16,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cStatusANS",,)

sleep(10000)
fTratButao(nOpc)
lPassou:=.T.
if nOpc<> 3
	cdesdob   := fRecComp()
	cAudPraz  := fRecprazos()
	cOnuscausa:= fRecOnus()

	// cSenha1    := fRecSenha1()

	fConsulCC(cCC1,1)
	fConsulCC(cCC2,2)
	fConsulCC(cCC3,3)
	fConsulCC(cCC4,4)
	fConsulCC(cCC5,5)

	fbloqRA()

// bloqueia combos a direita

endIf

oCBox5:SetItems( aTema )
oCBox9:SetItems( aStatusAns )
if !empty(cNumComPr)
	MsgAlert("Processo è DESDOBRAMENTO do processo "+cNumproc+"   !!! ","Atencao!")
elseif !empty(cdesdob)
	MsgAlert("Processo Contem DESDOBRAMENTO do processo "+cNumComPr+"   !!! ","Atencao!")
EndIf
//For i:= 1 to 5
//next 
oDlg1:Activate(,,,.T.)


Return

Static Function fAndPrz()
	U_caba411(cNCab411,cNproc411,cNCompP411)
	// fMovArqVar

	oDlg1:End()

Return

Static Function fonusCls()
	// U_caba412(cNCab411,cNproc411,cNCompP411)
	U_caba4122(cNCab411,cNproc411,cNCompP411)
	// fMovArqVar

	oDlg1:End()

Return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validar Codigo do custo de custo                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fConsulCC(cCC, Num)

	If !Empty(cCC)
		dbselectarea("CTT")
		dbsetorder(1)
		If dbseek(xFilial("CTT")+cCC)
			if Num == 1
				cCcDesc1:=ctt_desc01
				cEmailCtt1:=ctt_email
				lEmail1    := .F.
			elseif Num == 2
				cCcDesc2:=ctt_desc01
				cEmailCtt2:=ctt_email
				lEmail2    := .F.
			elseif Num == 3
				cCcDesc3:=ctt_desc01
				cEmailCtt3:=ctt_email
				lEmail3    := .F.
			elseif Num == 4
				cCcDesc4:=ctt_desc01
				cEmailCtt4:=ctt_email
				lEmail4    := .F.
			elseif Num == 5
				cCcDesc5:=ctt_desc01
				cEmailCtt5:=ctt_email
				lEmail5    := .F.
			EndIf
			// 	else
			//    cCcDesc01:=  ' '
		EndIF

	EndIf

Return(substr(ctt->CTT_CUSTO,1,4))


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta Bloqueio e desbloqueio de campos                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
Static Function ftcmpbloq()
	if empty(dDtsent2)
		oGet18:Disable()
		oTpSent:Disable()
		oSent:Disable()
	Endif
	if nComTut!='Sim' .and. nSusTut == 'Sim'
		oDescTut:Disable()
		oGet9:Disable()
		oGet10:Disable()
		if nComTut!="Sim"
			oCBox4:Disable()
		endIf
	EndIf
Return()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta Bloqueio e desbloqueio de campos                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
Static Function fdeletaReg()
	local cCompl := ' '
	local cPrazos:= ' '
	local cOnus  := ' '

	cCompl := fRecComp()
	cPrazos:= fRecprazos()
	cOnus  := fReconus()
	If !empty(cCompl)
		MsgAlert("Processo com  DESDOBRAMENTO  ,é necessario deletar desdobramento ante de continuar, Verifique  !!! ","Atencao!")
	EndIf

	If !empty(cPrazos)
		MsgAlert("Processo com  Prazo(s) Cadastrado(s)  ,é necessario deletar Prazos deste processo ante de continuar, Verifique  !!! ","Atencao!")
	EndIf

	If !empty(cOnus)
		MsgAlert("Processo com Onus da Causa Cadastrado(s)  ,é necessario deletar Onus da Causa deste processo ante de continuar, Verifique  !!! ","Atencao!")
	EndIf

	If (empty(cCompl) .or. !empty(cNumComPr)) .and. empty(cPrazos) .and. empty(cOnus)
		If ApMsgYesNo("Deseja excluir o Registro. Deseja excluir","SIMNAO")
			PBW->(RecLock("PBW",.F.))
			PBW->(DbDelete())
			PBW->(MsUnlock())
			If  _cEnvMail == 'S'
				fEnvEmail('DEL')
			EndIf
			MsgAlert("Processo APAGADO com Sucesso  !!! ","Atencao!")
			oDlg1:End()
		EndIf
	EndIf
Return()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³recupora complemento                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
Static Function fRecComp()
	local ret:= " "
	local cAliastmp      := GetNextAlias()
	Private cQuery       := " "

	cQuery := "select PBW_NUMPRO ,PBW_PROCES,PBW_NUMCOM , PBW_TPAUTO,PBW_TPACAO,PBW_ASSPRO,PBW_NOMRE1,PBW_NOMAU1 "
	cQuery += CRLF+ " from  " + RetSqlName("PBW") +" PBW "
	cQuery += CRLF+ " where PBW_filial = '"+xFilial('PBW')+ "' and PBW.d_E_L_E_T_ = ' ' "
	cQuery += CRLF+ " AND PBW_NUMPRO ="+ str(cNumCab,6,0) +" "
	cQuery += CRLF+ " AND PBW_PROCES ='"+ cNumproc +"' "
	if empty(cNumComPr)
		cQuery += CRLF+ " AND PBW_NUMCOM <> ' '"
	else
		cQuery += CRLF+ " AND PBW_NUMCOM = ' ' "
	EndIf
	If Select((cAliastmp)) <> 0
		(cAliastmp)->(DbCloseArea())
	Endif

	TCQuery cQuery New Alias (cAliastmp)

	(cAliastmp)->( DbGoTop() )

	While !Eof()
		//    ret+= "--------------------------------------------------------" + CRLF
		ret+= "N.Caberj -->" + str((cAliastmp)->PBW_NUMPRO,6,0) + CRLF
		ret+= "N.Processo -->" + (cAliastmp)->PBW_PROCES + CRLF
		ret+= "N.Complemento -->" + (cAliastmp)->PBW_NUMCOM + CRLF
		ret+= "Tp Autor -->" + (cAliastmp)->PBW_TPAUTO + CRLF
		ret+= "Tp Ação -->" + (cAliastmp)->PBW_TPACAO + CRLF
		ret+= "Tp Ass.Ação -->" + (cAliastmp)->PBW_ASSPRO + CRLF
		ret+= "Tp Nome Reu -->" + (cAliastmp)->PBW_NOMRE1 + CRLF
		ret+= "Tp Nome Autoro -->" + (cAliastmp)->PBW_NOMAU1 + CRLF
		ret+= "--------------------------------------------------------" + CRLF
		DbSkip()
	End

Return(ret)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³recupora Data e prazos 1                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
Static Function fRecprazos()
	local ret:= ''
	local cAliastmp      := GetNextAlias()
	Private cQuery       := " "

	cQuery := "select *  "
	cQuery += CRLF+ " from  " + RetSqlName("PBX") +" PBX "
	cQuery += CRLF+ " where PBX_filial = '"+xFilial('PBX')+ "' and PBX.d_E_L_E_T_ = ' ' "
	cQuery += CRLF+ " AND PBX_NUMPRO ="+ str(cNumCab,6,0) +" "
	cQuery += CRLF+ " AND PBX_PROCES ='"+ cNumproc +"' "
	cQuery += CRLF+ " AND PBX_NUMCOM = '"+ cNumComPr +"' "
	cQuery += CRLF+ " order by 1,2,3,4 "

	If Select((cAliastmp)) <> 0
		(cAliastmp)->(DbCloseArea())
	Endif

	TCQuery cQuery New Alias (cAliastmp)

	(cAliastmp)->( DbGoTop() )

	While !Eof()

		ret+= "Ass.Ação -->" + (cAliastmp)->PBX_ASSPRO + CRLF
		ret+= "N.Prazo  -->" + str((cAliastmp)->PBX_IDACPR,6,0) + CRLF
		ret+= "N.P.Caberj -->" + str((cAliastmp)->PBX_NUMPRO,6,0) + CRLF
		ret+= "N.Processo -->" + (cAliastmp)->PBX_PROCES + CRLF
		ret+= "N.Complemento -->" + (cAliastmp)->PBX_NUMCOM + CRLF
		ret+= "Data Incial  -->" + DtoC(stod((cAliastmp)->PBX_DTINCP))
		ret+= " --- Hora Inical  -->" + substr(str((cAliastmp)->PBX_HRINCP,4,0),1,2) + ":" + substr(str((cAliastmp)->PBX_HRINCP,4,0),3,2) + CRLF

		ret+= "Data Final   -->" + DtoC(stod((cAliastmp)->PBX_DTFIMP))
		ret+= " --- Hora Final   -->" + substr(str((cAliastmp)->PBX_HRFIMP,4,0),1,2) + ":" + substr(str((cAliastmp)->PBX_HRFIMP,4,0),3,2) + CRLF

		ret+= "--------------------------------------------------------" + CRLF
		DbSkip()
	End

Return(ret)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³recupora onus                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
Static Function fReconus()
	local ret:=''
	local cAliastmp      := GetNextAlias()

	Private cQuery       := " "

	cQuery := "SELECT PBY.* , NVL(E2_SALDO,0.00) SALE2 , NVL(E2_BAIXA,' ') BAXE2, NVL(E2_VENCREA,' ') VENCREA2,  NVL(E1_SALDO,0.00) SALE1 , NVL(E1_BAIXA,' ') BAXE1 ,NVL(E1_VENCREA,' ') VENCREA1"
	cQuery += CRLF+ " from  " + RetSqlName("PBY") +" PBY ,"  + RetSqlName("SE2") +" SE2 ,"  + RetSqlName("SE1") +" SE1 "
	cQuery += CRLF+ " where PBY_filial = '"+xFilial('PBY')+ "' and PBY.d_E_L_E_T_ = ' ' "

	cQuery += CRLF+ " AND E2_FILIAL(+) = '"+xFilial('SE2')+ "' AND SE2.d_e_l_e_t_(+) = ' ' "
	cQuery += CRLF+ " AND E1_FILIAL(+) = '"+xFilial('SE1')+ "' AND SE1.d_e_l_e_t_(+) = ' ' "

	cQuery += CRLF+ " AND PBY_NUMPRO ="+ str(cNumCab,6,0) +" "
	cQuery += CRLF+ " AND PBY_PROCES ='"+ cNumproc +"' "
	cQuery += CRLF+ " AND PBY_NUMCOM = '"+ cNumComPr +"' "

	cQuery += CRLF+ " AND E2_PREFIXO(+) = PBY_PREFPG"
	cQuery += CRLF+ " AND E2_NUM(+)     = PBY_TITPGT"
	cQuery += CRLF+ " AND E2_PARCELA(+) = PBY_PARCPG"
	cQuery += CRLF+ " AND E2_TIPO(+)    = PBY_TIPOPG"
	cQuery += CRLF+ " AND E2_FORNECE(+) = PBY_CODFOR"

	cQuery += CRLF+ " AND E1_PREFIXO(+) = PBY_PREFRC"
	cQuery += CRLF+ " AND E1_NUM(+)     = PBY_TITREC"
	cQuery += CRLF+ " AND E1_PARCELA(+) = PBY_PARCRC"
	cQuery += CRLF+ " AND E1_TIPO(+)    = PBY_TIPORC"
	cQuery += CRLF+ " AND E1_CLIENTE(+) = PBY_CODCLI"

	cQuery += CRLF+ " order by 1,2,3,4 "

	TCQuery cQuery New Alias (cAliastmp)

	(cAliastmp)->( DbGoTop() )

	While !Eof()
  /*     If (cAliastmp)->PBY_PARCRC == '0'
          nNumParc:=0 
       Else    
          nNumParc:= aScan(aParcela, {|X|X[1] == (cAliastmp)->PBY_PARCRC   })
       EndIf
  */       
		// Vlrsai:= (cAliastmp)->PBY_VLONUS  Picture "@E 999,999,999.99"
		ret+= "--------------------------------------------------------" + CRLF
		ret+= "N.Operadora -->" + str((cAliastmp)->PBY_IDACPR,6,0) + CRLF

		//   ret+= "Tp Onus -->" + (cAliastmp)->PBY_TPONUS + CRLF
		if ((cAliastmp)->PBY_LTITRC == 'T') .OR. (!EMPTY((cAliastmp)->PBY_TITRPS))
			ret+= "Tp Repase(C/Receber)--> " + (cAliastmp)->PBY_TITRPS + CRLF
			ret+= "Nome Cliente        --> " + (cAliastmp)->PBY_NOMCLI  + CRLF
			ret+= "Valor Do Repase     --> " + Transform((cAliastmp)->PBY_VLRREC,"@R  999,999,999.99")  + CRLF
			ret+= "Data Vencto         --> " + DtoC(STOD((cAliastmp)->vencrea1)) + CRLF
			//ret+= "Data Vencto         --> " + DtoC(STOD((cAliastmp)->PBY_DTVREC)) + CRLF
			ret+= "Data Baixa          --> " + DtoC(STOD((cAliastmp)->BAXE1)) + CRLF
			ret+= "Saldo Rec Do Repase --> " + Transform((cAliastmp)->SALE1,"@R  999,999,999.99")  + CRLF
			ret+= "Parcela Titulo      --> " + (cAliastmp)->PBY_PARCRC +"("+cValToChar(nNumParc)+")"+ CRLF
			ret+= "--------------------------------------------------------" + CRLF
		EndIf

		if ((cAliastmp)->PBY_LTITPG == 'T') .OR. (!EMPTY((cAliastmp)->PBY_TPONUS))
			ret+= "Tp Onus (C/Pagar)   --> " + (cAliastmp)->PBY_TPONUS + CRLF
			ret+= "Nome Favorecido     --> " + (cAliastmp)->PBY_NOMFOR  + CRLF
			ret+= "Valor Do Onus       --> " + Transform((cAliastmp)->PBY_VLONUS,"@R  999,999,999.99")  + CRLF
			ret+= "Data Vencto         --> " + DtoC(STOD((cAliastmp)->vencrea2)) + CRLF
			//ret+= "Data Vencto         --> " + DtoC(STOD((cAliastmp)->PBY_DTVPAG)) + CRLF
			ret+= "Data Baixa          --> " + DtoC(STOD((cAliastmp)->BAXE2)) + CRLF
			ret+= "Saldo a Pgr Do Onus --> " + Transform((cAliastmp)->SALE2,"@R  999,999,999.99")  + CRLF
			ret+= "Parcela Titulo      --> " + (cAliastmp)->PBY_PARCPG + CRLF
			ret+= "--------------------------------------------------------" + CRLF
		EndIf


		DbSkip()
	End

Return(ret)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³recupora onus                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
Static Function fRecSenha1()
	local ret:=''
	local cAliastmp      := GetNextAlias()

	Private cQuery       := " "

	cQuery := "       Select 'S.A.D.T' Tipo , bea_senha SENHA ,"
	cQuery += CRLF+ " bea_codrda CODRDA, bea_nomrda NOMRDA, "
	cQuery += CRLF+ " bea_codemp CODEMP, bea_matric MATRIC, bea_tipreg TIPREG, bea_nomusr NOMUSR, "
	cQuery += CRLF+ " bg9_descri DESCEMP, "
	cQuery += CRLF+ " bea_mespag MESPAG, bea_anopag ANOPAG, "
	cQuery += CRLF+ " bea_descid DESCID , "
	cQuery += CRLF+ " substr(bea_dtdigi,7,2)||'/'||substr(bea_dtdigi,5,2)||'/'||substr(bea_dtdigi,1,4) dtdigit , "
	cQuery += CRLF+ " BEA_XDTLIB XDTLIB"
	cQuery += CRLF+ "  from  " + RetSqlName("BEA") +" BEA ,  "+ RetSqlName("BG9") +" BG9 "
	cQuery += CRLF+ " where BEA_filial = '"+xFilial('BEA')+ "' and BEA.d_E_L_E_T_ = ' ' "
	cQuery += CRLF+ "   AND BG9_filial = '"+xFilial('BG9')+ "' and BG9.d_E_L_E_T_ = ' ' "
	cQuery += CRLF+ "   and bg9_codigo = bea_codemp  "
	cQuery += CRLF+ "   and trim(bea_yproju) = '"+ trim(cNumproc) +"' "

	cQuery +=  CRLF+" Union All "

	cQuery += CRLF+ "       Select  'internação' tipo , BE4_senha SENHA, "
	cQuery += CRLF+ "BE4_codrda CODRDA, BE4_nomrda NOMRDA ,"
	cQuery += CRLF+ "BE4_codemp CODEMP, BE4_matric MATRIC, BE4_tipreg TIPREG, BE4_nomusr NOMUSR,"
	cQuery += CRLF+ "bg9_descri DESCEMP,"
	cQuery += CRLF+ "BE4_mespag MESPAG, BE4_anopag ANOPAG,"
	cQuery += CRLF+ "BE4_descid DESCID, "
	cQuery += CRLF+ " substr(be4_dtdigi,7,2)||'/'||substr(be4_dtdigi,5,2)||'/'||substr(be4_dtdigi,1,4) dtdigit , "
	cQuery += CRLF+ "BE4_XDTLIB  XDTLIB "
	cQuery += CRLF+ "  from  " + RetSqlName("BE4") +" BE4 ,  "+ RetSqlName("BG9") +" BG9 "
	cQuery += CRLF+ "where BE4_filial = '"+xFilial('BE4')+ "' and BE4.d_E_L_E_T_ = ' '"
	cQuery += CRLF+ "AND BG9_filial = '"+xFilial('BG9')+ "' and BG9.d_E_L_E_T_ = ' '"
	cQuery += CRLF+ "and bg9_codigo = BE4_codemp "
	cQuery += CRLF+ "and trim(be4_yproju) = '"+ trim(cNumproc) +"' "


	If Select((cAliastmp)) <> 0
		(cAliastmp)->(DbCloseArea())
	Endif
	TCQuery cQuery New Alias (cAliastmp)

	(cAliastmp)->( DbGoTop() )

	While !Eof()
		If !empty(ret)
			ret+= trim("--------------------------------------------------------") + CRLF
		EndIf
		ret+= trim(" Tp de Senha    --> " + (cAliastmp)->tipo )+ CRLF
		ret+= trim(" Senha          --> " + (cAliastmp)->SENHA )+ CRLF
		ret+= trim(" Ident. Rda     --> " + (cAliastmp)->CODRDA +' - '+ (cAliastmp)->NOMRDA) + CRLF
		ret+= trim(" Matr.  Benefic --> " + (cAliastmp)->CODEMP +'.'+(cAliastmp)->MATRIC +'-'+(cAliastmp)->TIPREG)  + CRLF
		ret+= trim(" Nome . Benefic --> " + (cAliastmp)->NOMUSR) + CRLF
		ret+= trim(" Nome . Empresa --> " + (cAliastmp)->DESCEMP) + CRLF
		ret+= trim(" Descrição. Cid --> " + (cAliastmp)->DESCID) + CRLF
		ret+= trim(" Data Digitação --> " + (cAliastmp)->dtdigit) + CRLF
		//ret+= "--------------------------------------------------------" + CRLF

		DbSkip()
	End
	If !empty(ret)
		ret+= trim("--------------------------------------------------------") + CRLF
	EndIf
Return(ret)



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a consulta do Reus                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
Static Function fMConsReus(tpreu,Num)

	If nopcm == 3 .or. lPassou
		If trim(tpreu) == "CABERJ"
			If Num == 1
				cCpfCnpj1:= '42182170000184'
				cNomeReus1:= 'Caixa de Assistencia á Saude CABERJ '
			ElseIf Num == 2
				cCpfCnpj2:= '42182170000184'
				cNomeReus2:= 'Caixa de Assistencia á Saude CABERJ '
/*	ElseIf Num == 3
	   cCpfCnpj3:= '1234567890' 
	   cNomeReus3:= 'Caixa de Assistencia á Saude CABERJ '  
	ElseIf Num == 4
	   cCpfCnpj4:= '1234567890' 
	   cNomeReus4:= 'Caixa de Assistencia á Saude CABERJ '  */
	EndIf                             
elseIf trim(tpreu) == "INTEGRAL"   
	If Num == 1
	   cCpfCnpj1 := '07844436000106' 
	   cNomeReus1:= 'Caberj Integral Saúde' 
	ElseIf Num == 2
	   cCpfCnpj2 := '07844436000106' 
	   cNomeReus2:= 'Caberj Integral Saúde' 
/*	ElseIf Num == 3
	   cCpfCnpj3 := '0987654321' 
	   cNomeReus3:= 'Caberj Integral Saúde'
	ElseIf Num == 4
	   cCpfCnpj4 := '0987654321' 
	   cNomeReus4:= 'Caberj Integral Saúde'  */
	EndIf                                    
elseIf tpreu==""    
	If Num == 1
	   cCpfCnpj1 := ' ' 
	   cNomeReus1:= ' '            
	   if lPassou
          oNomeReus1:SetFocus()  
       EndIf   
	ElseIf Num == 2
	   cCpfCnpj2 := ' ' 
	   cNomeReus2:= ' ' 
	   if lPassou	   
	      ocbox6:SetFocus()
	   EndIf   
	ElseIf Num == 3
	   cCpfCnpj3 := ' ' 
	   cNomeReus3:= ' '
   	   if lPassou	   
	      ocbox8:SetFocus()
   	   EndIf  
	ElseIf Num == 4
	   cCpfCnpj4 := ' ' 
	   cNomeReus4:= ' '
   	    if lPassou	   
          ocbox10:SetFocus() 	
       EndIf   
    EndIf	 
 EndIf	  
EndIf
 if lPassou                                                       
  If trim(tpreu)$ "CABERJ|INTEGRAL|OUTROS"  .or. tpreu=="" 
// tratamento para 1 seleção  
	   
	oNomeReus1:show() 
	oNomeReus2:hide() 
	oNomeReus3:hide()
	oNomeReus4:hide() 
	oNomeReus5:hide() 
	oNomeReus6:hide()
	oNomeReus1:ctrlrefresh()        
	oNomeReus2:ctrlrefresh()       
	oNomeReus3:ctrlrefresh()       
	oNomeReus4:ctrlrefresh() 
    oNomeReus5:ctrlrefresh() 	          
    oNomeReus6:ctrlrefresh() 	         
// tratamento para 2 seleção	
	 oGet61:show()  
	 oGet62:hide() 
	 oGet63:hide()  
	 oGet64:hide()  
	 oGet65:hide()  
	 oGet66:hide() 
	 oGet61:ctrlrefresh() 
	 oGet62:ctrlrefresh() 
	 oGet63:ctrlrefresh() 
	 oGet64:ctrlrefresh()   
	 oGet65:ctrlrefresh()   
	 oGet66:ctrlrefresh()  
	 
// tratamento para 3 seleção	
	 oGet81:show()  
	 oGet82:hide() 
	 oGet83:hide()  
	 oGet84:hide()  
	 oGet85:hide()  
	 oGet86:hide() 
	 oGet81:ctrlrefresh() 
	 oGet82:ctrlrefresh() 
	 oGet83:ctrlrefresh() 
	 oGet84:ctrlrefresh()	  
	 oGet85:ctrlrefresh()	  
 	 oGet86:ctrlrefresh()	 
	 
// tratamento para 4 seleção	
	 oGet201:show()  
	 oGet202:hide() 
	 oGet203:hide()  
	 oGet204:hide() 
	 oGet205:hide()  
	 oGet206:hide() 
	 oGet201:ctrlrefresh() 
	 oGet202:ctrlrefresh() 
	 oGet203:ctrlrefresh() 
	 oGet204:ctrlrefresh()	  
	 oGet205:ctrlrefresh()	  
	 oGet206:ctrlrefresh()	 
 	 
elseIf trim(tpreu) == "RDA"  
// tratamento para 1 seleção
     oNomeReus1:hide() 
     oNomeReus2:show() 
   	 oNomeReus3:hide()
     oNomeReus4:hide() 
     oNomeReus5:hide() 
     oNomeReus6:hide()
	 oNomeReus1:ctrlrefresh()        
	 oNomeReus2:ctrlrefresh()       
	 oNomeReus3:ctrlrefresh()       
	 oNomeReus4:ctrlrefresh() 
	 oNomeReus5:ctrlrefresh() 
	 oNomeReus6:ctrlrefresh()
	 
// tratamento para 2 seleção	
	 oGet61:hide()  
	 oGet62:show()
	 oGet63:hide()  
	 oGet64:hide()  
	 oGet65:hide()  
	 oGet66:hide() 
	 oGet61:ctrlrefresh() 
	 oGet62:ctrlrefresh() 
	 oGet63:ctrlrefresh() 
	 oGet64:ctrlrefresh()   
	 oGet65:ctrlrefresh()   
	 oGet66:ctrlrefresh()  
	 
// tratamento para 3 seleção	
	 oGet81:hide() 
	 oGet82:show() 
	 oGet83:hide()  
	 oGet84:hide()  
	 oGet85:hide()  
	 oGet86:hide() 
	 oGet81:ctrlrefresh() 
	 oGet82:ctrlrefresh() 
	 oGet83:ctrlrefresh() 
	 oGet84:ctrlrefresh()	  
 	 oGet85:ctrlrefresh()	  
 	 oGet86:ctrlrefresh()	 
	 
// tratamento para 4 seleção	
	 oGet201:hide()  
	 oGet202:show() 
	 oGet203:hide()  
	 oGet204:hide()  
	 oGet205:hide()   
	 oGet206:hide() 
	 oGet201:ctrlrefresh() 
	 oGet202:ctrlrefresh() 
	 oGet203:ctrlrefresh() 
	 oGet204:ctrlrefresh()	        
	 oGet205:ctrlrefresh()	        	  	                           
	 oGet206:ctrlrefresh()	        	  	                          
	 
elseIf trim(tpreu) == "FORNECEDOR"

// tratamento para 1 seleção
     oNomeReus1:hide() 
     oNomeReus2:hide() 
   oNomeReus3:show()
   oNomeReus4:hide() 
   oNomeReus5:hide() 
   oNomeReus6:hide()
	 oNomeReus1:ctrlrefresh()        
	 oNomeReus2:ctrlrefresh()       
	 oNomeReus3:ctrlrefresh()       
	 oNomeReus4:ctrlrefresh() 
	 oNomeReus5:ctrlrefresh() 
	 oNomeReus6:ctrlrefresh()
	 
// tratamento para 2 seleção	
	 oGet61:hide()  
	 oGet62:hide()
	 oGet63:show()  
	 oGet64:hide()  
	 oGet65:hide()  
	 oGet66:hide() 
	 oGet61:ctrlrefresh() 
	 oGet62:ctrlrefresh() 
	 oGet63:ctrlrefresh() 
	 oGet64:ctrlrefresh()   
	 oGet65:ctrlrefresh()   
	 oGet66:ctrlrefresh()  
	 
// tratamento para 3 seleção	
	 oGet81:hide() 
	 oGet82:hide() 
	 oGet83:show()  
	 oGet84:hide() 
	 oGet85:hide() 
	 oGet86:hide()
	 oGet81:ctrlrefresh() 
	 oGet82:ctrlrefresh() 
	 oGet83:ctrlrefresh() 
	 oGet84:ctrlrefresh()	  
	 oGet85:ctrlrefresh()	  
	 oGet86:ctrlrefresh()	 
	 
// tratamento para 4 seleção	
	 oGet201:hide()  
	 oGet202:hide()                                                                   
	 oGet203:show()  
	 oGet204:hide()  
 	 oGet205:hide()  
 	 oGet206:hide() 
	 oGet201:ctrlrefresh() 
	 oGet202:ctrlrefresh() 
	 oGet203:ctrlrefresh() 
	 oGet204:ctrlrefresh()	                     
	 oGet205:ctrlrefresh()	                     
	 oGet206:ctrlrefresh()	                    
	 
elseIf trim(tpreu) == "BENEFICIARIO"

// tratamento para 1 seleção
     oNomeReus1:hide() 
     oNomeReus2:hide() 
   	 oNomeReus3:hide()
     oNomeReus4:show()
     oNomeReus5:hide() 
     oNomeReus6:hide()
	 oNomeReus1:ctrlrefresh()        
	 oNomeReus2:ctrlrefresh()       
	 oNomeReus3:ctrlrefresh()       
	 oNomeReus4:ctrlrefresh() 
	 oNomeReus5:ctrlrefresh()	  
	 oNomeReus6:ctrlrefresh()	 
	 
// tratamento para 2 seleção	
	 oGet61:hide()  
	 oGet62:hide()
	 oGet63:hide()  
	 oGet64:show()   
 	 oGet65:hide()   
 	 oGet66:hide()  
	 oGet61:ctrlrefresh() 
	 oGet62:ctrlrefresh() 
	 oGet63:ctrlrefresh() 
	 oGet64:ctrlrefresh()   
	 oGet65:ctrlrefresh()  
	 oGet66:ctrlrefresh()  
// tratamento para 3 seleção	
	 oGet81:hide() 
	 oGet82:hide() 
	 oGet83:hide()  
	 oGet84:show()       
	 oGet85:hide()  	  
	 oGet86:hide()  	 
	 oGet81:ctrlrefresh() 
	 oGet82:ctrlrefresh() 
	 oGet83:ctrlrefresh() 
	 oGet84:ctrlrefresh()	  
	 oGet85:ctrlrefresh()	  
	 oGet86:ctrlrefresh()	 
	 
// tratamento para 4 seleção	
	 oGet201:hide()  
	 oGet202:hide() 
	 oGet203:hide()  
	 oGet204:show()               
	 oGet205:hide()  	  
	 oGet206:hide()  	 
	 oGet201:ctrlrefresh() 
	 oGet202:ctrlrefresh() 
	 oGet203:ctrlrefresh() 
	 oGet204:ctrlrefresh()	  
 	 oGet205:ctrlrefresh()	  
 	 oGet206:ctrlrefresh()	 
	 
elseIf trim(tpreu) == "EMP.CLIENTE" 

// tratamento para 1 seleção
     oNomeReus1:hide() 
     oNomeReus2:hide() 
   	 oNomeReus3:hide()
     oNomeReus4:hide()              
     oNomeReus5:show()                   
	 oNomeReus6:hide()              
	 oNomeReus1:ctrlrefresh()        
	 oNomeReus2:ctrlrefresh()       
	 oNomeReus3:ctrlrefresh()       
	 oNomeReus4:ctrlrefresh()
	 oNomeReus5:ctrlrefresh()
	 oNomeReus6:ctrlrefresh()
// tratamento para 2 seleção	
	 oGet61:hide()  
	 oGet62:hide()
	 oGet63:hide()  
	 oGet64:hide() 
	 oGet65:show() 
	 oGet66:hide() 
	  
	 oGet61:ctrlrefresh() 
	 oGet62:ctrlrefresh() 
	 oGet63:ctrlrefresh() 
	 oGet64:ctrlrefresh()   
 	 oGet65:ctrlrefresh()   
 	 oGet66:ctrlrefresh()  
	 
// tratamento para 3 seleção	
	 oGet81:hide() 
	 oGet82:hide() 
	 oGet83:hide()  
	 oGet84:hide()  
	 oGet85:show()  
	 oGet86:hide()
	 
	 oGet81:ctrlrefresh() 
	 oGet82:ctrlrefresh() 
	 oGet83:ctrlrefresh() 
	 oGet84:ctrlrefresh()	  
	 oGet85:ctrlrefresh()	 	 
	 oGet86:ctrlrefresh()	 	 
	 
// tratamento para 4 seleção	
	 oGet201:hide()  
	 oGet202:hide() 
	 oGet203:hide()  
	 oGet204:hide() 
     oGet205:show() 	  
     oGet206:hide() 	 
     
	 oGet201:ctrlrefresh() 
	 oGet202:ctrlrefresh() 
	 oGet203:ctrlrefresh() 
	 oGet204:ctrlrefresh()	 
	 oGet205:ctrlrefresh()	  
	 oGet206:ctrlrefresh()	 
	 
elseIf trim(tpreu) == "ADM.BENEFICIOS" 

// tratamento para 1 seleção
     oNomeReus1:hide() 
     oNomeReus2:hide() 
   	 oNomeReus3:hide()
     oNomeReus4:hide()              
     oNomeReus5:hide()                   
	 oNomeReus6:show()              
	 oNomeReus1:ctrlrefresh()        
	 oNomeReus2:ctrlrefresh()       
	 oNomeReus3:ctrlrefresh()       
	 oNomeReus4:ctrlrefresh()
	 oNomeReus5:ctrlrefresh()
	 oNomeReus6:ctrlrefresh()
// tratamento para 2 seleção	
	 oGet61:hide()  
	 oGet62:hide()
	 oGet63:hide()  
	 oGet64:hide() 
	 oGet65:hide()
	 oGet66:show()
	  
	 oGet61:ctrlrefresh() 
	 oGet62:ctrlrefresh() 
	 oGet63:ctrlrefresh() 
	 oGet64:ctrlrefresh()   
 	 oGet65:ctrlrefresh()   
 	 oGet66:ctrlrefresh()  
	 
// tratamento para 3 seleção	
	 oGet81:hide() 
	 oGet82:hide() 
	 oGet83:hide()  
	 oGet84:hide()  
	 oGet85:hide() 
	 oGet86:show()
	 
	 oGet81:ctrlrefresh() 
	 oGet82:ctrlrefresh() 
	 oGet83:ctrlrefresh() 
	 oGet84:ctrlrefresh()	  
	 oGet85:ctrlrefresh()	 	 
	 oGet86:ctrlrefresh()	 	 
	 
// tratamento para 4 seleção	
	 oGet201:hide()  
	 oGet202:hide() 
	 oGet203:hide()  
	 oGet204:hide() 
     oGet205:hide() 	  
     oGet206:show() 	 
     
	 oGet201:ctrlrefresh() 
	 oGet202:ctrlrefresh() 
	 oGet203:ctrlrefresh() 
	 oGet204:ctrlrefresh()	 
	 oGet205:ctrlrefresh()	  
	 oGet206:ctrlrefresh()	 
	 
	                    
  EndIf	 
endIf 	                     
return()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Consulta do Reus                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
Static Function fConsulReu(tpreu,identif,Num)                                          
if lPassou .or. nopcm == 3                  
   If trim(tpreu) == "RDA"  
              
    If Num == 1
	   cCpfCnpj1 := substr(identif,1,14)
	   cNomeReus1:= substr(identif,15,40) 
   	   oGet5:ctrlrefresh()	 
       oNomeReus2:ctrlrefresh() 
	ElseIf Num == 2       
	   cCpfCnpj2 := substr(identif,1,14)
	   cNomeReus2:= substr(identif,15,40) 
   	   oGet7:ctrlrefresh()	 
       oGet62:ctrlrefresh()
	ElseIf Num == 3
	   cCpfCnpj3 := substr(identif,1,14)
	   cNomeReus3:= substr(identif,15,40) 
   	   oGet19:ctrlrefresh()	 
       oGet82:ctrlrefresh()
	ElseIf Num == 4      
       cCpfCnpj4 := substr(identif,1,14)
	   cNomeReus4:= substr(identif,15,40) 
   	   oGet21:ctrlrefresh()	 
       oGet202:ctrlrefresh()
	EndIf                             
  elseIf trim(tpreu) == "FORNECEDOR"
	If Num == 1
	   cCpfCnpj1 := substr(identif,1,14)
	   cNomeReus1:= substr(identif,15,40) 
   	   oGet5:ctrlrefresh()	 
       oNomeReus3:ctrlrefresh()
	ElseIf Num == 2       
	   cCpfCnpj2 := substr(identif,1,14)
	   cNomeReus2:= substr(identif,15,40) 
   	   oGet7:ctrlrefresh()	 
       oGet63:ctrlrefresh()
	ElseIf Num == 3
	   cCpfCnpj3 := substr(identif,1,14)
	   cNomeReus3:= substr(identif,15,40) 
   	   oGet19:ctrlrefresh()	 
       oGet83:ctrlrefresh()
	ElseIf Num == 4      
       cCpfCnpj4 := substr(identif,1,14)
	   cNomeReus4:= substr(identif,15,40) 
   	   oGet21:ctrlrefresh()	 
       oGet203:ctrlrefresh()
	EndIf
 elseIf trim(tpreu) == "BENEFICIARIO"
	If Num == 1
	   cCpfCnpj1 := substr(identif,1,11)
	   cNomeReus1:= substr(identif,12,40) 
   	   oGet5:ctrlrefresh()	 
       oNomeReus4:ctrlrefresh()
	ElseIf Num == 2       
	   cCpfCnpj2 := substr(identif,1,11)
	   cNomeReus2:= substr(identif,12,40) 
   	   oGet7:ctrlrefresh()	 
       oGet64:ctrlrefresh()
	ElseIf Num == 3
	   cCpfCnpj3 := substr(identif,1,11)
	   cNomeReus3:= substr(identif,12,40) 
   	   oGet19:ctrlrefresh()	 
       oGet84:ctrlrefresh()
	ElseIf Num == 4      
       cCpfCnpj4 := substr(identif,1,11)
	   cNomeReus4:= substr(identif,12,40) 
   	   oGet21:ctrlrefresh()	 
       oGet204:ctrlrefresh()
	EndIf        
//fConsulReu("EMP.CLIENTES",cNomeReus1,1))		
 elseIf trim(tpreu) == "EMP.CLIENTE"
	If Num == 1
	   cCpfCnpj1 := substr(identif,1,14)
	   cNomeReus1:= substr(identif,15,40) 
   	   oGet5:ctrlrefresh()	 
       oNomeReus5:ctrlrefresh()
	ElseIf Num == 2       
	   cCpfCnpj2 := substr(identif,1,14)
	   cNomeReus2:= substr(identif,15,40) 
   	   oGet7:ctrlrefresh()	 
       oGet65:ctrlrefresh()
	ElseIf Num == 3
	   cCpfCnpj3 := substr(identif,1,14)
	   cNomeReus3:= substr(identif,15,40) 
   	   oGet19:ctrlrefresh()	 
       oGet85:ctrlrefresh()
	ElseIf Num == 4      
       cCpfCnpj4 := substr(identif,1,14)
	   cNomeReus4:= substr(identif,15,40) 
   	   oGet21:ctrlrefresh()	 
       oGet205:ctrlrefresh()
	EndIf        	 
 elseIf trim(tpreu) == "ADM.BENEFICIOS"
	If Num == 1
	   cCpfCnpj1 := substr(identif,1,14)
	   cNomeReus1:= substr(identif,15,40) 
   	   oGet5:ctrlrefresh()	 
       oNomeReus5:ctrlrefresh()
	ElseIf Num == 2       
	   cCpfCnpj2 := substr(identif,1,14)
	   cNomeReus2:= substr(identif,15,40) 
   	   oGet7:ctrlrefresh()	 
       oGet65:ctrlrefresh()
	ElseIf Num == 3
	   cCpfCnpj3 := substr(identif,1,14)
	   cNomeReus3:= substr(identif,15,40) 
   	   oGet19:ctrlrefresh()	 
       oGet85:ctrlrefresh()
	ElseIf Num == 4      
       cCpfCnpj4 := substr(identif,1,14)
	   cNomeReus4:= substr(identif,15,40) 
   	   oGet21:ctrlrefresh()	 
       oGet205:ctrlrefresh()
	EndIf        		
EndIf    
EndIf   
return()



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a consulta do autor                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fMConsAut(_cParam) 

If trim(nTpAutor) == "Beneficiario"
       oDescAut12:show() 
       oDescAut22:show() 
       oDescAut32:show() 
       oDescAut42:show()     
       oDescAut52:show() 
Else   
       oDescAut12:hide()
       oDescAut22:hide() 
       oDescAut32:hide() 
       oDescAut42:hide()     
       oDescAut52:hide()        
EndIf

If trim(nTpAutor) == "RDA"
       oDescAut13:show() 
       oDescAut23:show()
       oDescAut33:show() 
       oDescAut43:show()     
       oDescAut53:show()
Else                    
       oDescAut13:hide() 
       oDescAut23:hide()
       oDescAut33:hide() 
       oDescAut43:hide()     
       oDescAut53:hide()
EndIf                      
                                                                    
If trim(nTpAutor) == "Colaborador"   
       oDescAut14:show() 
       oDescAut24:show()
       oDescAut34:show() 
       oDescAut44:show()     
       oDescAut54:show()
Else                    
       oDescAut14:hide() 
       oDescAut24:hide()
       oDescAut34:hide() 
       oDescAut44:hide()     
       oDescAut54:hide()                                     
EndIf                    

If (trim(nTpAutor) == "Outros" .or.trim(nTpAutor) == "Reclamante".or.trim(nTpAutor) =="INSTITUCIONAL" .OR. trim(nTpAutor) == "Proc.ANS")

   If trim(nTpAutor) == "INSTITUCIONAL"  .and. cempant == '01' 
       cDescAut1 := 'CABERJ - CAIXA DE ASSISTENCIA À SAÚDE'
       cIdentAut1:= '42182170000184'
   Elseif trim(nTpAutor) == "INSTITUCIONAL"  .and. cempant == '02'            
       cDescAut1 := 'CABERJ INTEGRAL SAUDE S.A.'
       cIdentAut1:= '7844436000106' 
   Elseif trim(nTpAutor) == "Proc.ANS"
       cDescAut1 := 'AGENCIA NACIONAL DE SAUDE SUPLEMENTAR - ANS'
       cIdentAut1:= '03589068000146'
   EndiF   
           
    oDescAut11:show() 
    oDescAut21:show()
    oDescAut31:show() 
    oDescAut41:show()     
    oDescAut51:show()
Else                    
    oDescAut11:hide() 
    oDescAut21:hide()
    oDescAut31:hide() 
    oDescAut41:hide()     
    oDescAut51:hide()
EndIf                      
       oDescAut11:ctrlrefresh() 
       oDescAut21:ctrlrefresh()
       oDescAut31:ctrlrefresh() 
       oDescAut41:ctrlrefresh()     
       oDescAut51:ctrlrefresh()
       
       oDescAut12:ctrlrefresh() 
       oDescAut22:ctrlrefresh()
       oDescAut32:ctrlrefresh() 
       oDescAut42:ctrlrefresh()     
       oDescAut52:ctrlrefresh()
      
       oDescAut13:ctrlrefresh() 
       oDescAut23:ctrlrefresh()
       oDescAut33:ctrlrefresh() 
       oDescAut43:ctrlrefresh()     
       oDescAut53:ctrlrefresh()
       
       oDescAut14:ctrlrefresh() 
       oDescAut24:ctrlrefresh()
       oDescAut34:ctrlrefresh() 
       oDescAut44:ctrlrefresh()     
       oDescAut54:ctrlrefresh()
 
return() 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Faz consulta do autor                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fFConsAut(cons,num)  

If trim(nTpAutor) == "Beneficiario"             
     BA1->(DbSetOrder(2))
     If BA1->(DbSeek(xFilial("BA1")+trim(cons)))   
        cba1codpla:=ba1->ba1_codpla       
        cba1nome:=ba1->ba1_nomusr
        ba1cpf  :=ba1->ba1_cpfusr   
     else                         
        cba1codpla:=' '
        cba1nome:=' '
        ba1cpf  :=' '
     EndIf     
		
     BA3->(dbSetOrder(1))
     if BA3->(dbSeek(xFilial("BA3")+substr(cons,1,14))) 
        ba3codcli:=ba3->ba3_codcli                                 
     else 
        ba3codcli:=' '        
     EndIf  
     BI3->(DbSetorder(01))     
     IF BI3->(DBSeek(xFilial("BI3") +'0001'+cba1codpla ) )
        IF nOpcm==3                                        
           cPlanAnt:=bi3->BI3_NREDUZ
        EndiF                  
        cPlanAtu:=bi3->BI3_NREDUZ                        
     else                                           
        IF nOpcm==3                                        
           cPlanAnt:=' ' 
        EndiF                  
        cPlanAtu:=' '                         
     EndIf   
     IF nOpcm==3
        If num == 1                       
		   cIdentAut1:=ba1cpf
		   cDescAut1 :=cba1nome
		   cPlaUsuAt1:=cPlanAtu
		   cPlaUsuOr1:=cPlanAnt
		   cForCli1  := ba3codcli 
		   oDescAut21:ctrlrefresh()
	    ElseIf num == 2
           cIdentAut2:=ba1cpf
		   cDescAut2 :=cba1nome
		   cPlaUsuAt2:=cPlanAtu
		   cPlaUsuOr2:=cPlanAnt
		   cForCli2  := ba3codcli  
		   oDescAut22:ctrlrefresh()
        ElseIf num == 3 
           cIdentAut3:=ba1cpf
		   cDescAut3 :=cba1nome
		   cPlaUsuAt3:=cPlanAtu                                                                 
		   cPlaUsuOr3:=cPlanAnt
		   cForCli3  := ba3codcli
		   oDescAut23:ctrlrefresh()
        ElseIf num == 4  
           cIdentAut4:=ba1cpf
		     cDescAut4 :=cba1nome
		   cPlaUsuAt4:=cPlanAtu
	   	   cPlaUsuOr4:=cPlanAnt
	  	   cForCli4  := ba3codcli
		   oDescAut24:ctrlrefresh()
        ElseIf num == 5  
           cIdentAut5:=ba1cpf
		   cDescAut5 :=cba1nome
		   cPlaUsuAt5:=cPlanAtu
		   cPlaUsuOr5:=cPlanAnt
		   cForCli5  := ba3codcli
		   oDescAut25:ctrlrefresh()
        EndIf
     Else
        If num == 1                       
		   cPlaUsuAt1:=cPlanAtu
	    ElseIf num == 2
		   cPlaUsuAt2:=cPlanAtu
        ElseIf num == 3 
		   cPlaUsuAt3:=cPlanAtu                                                                 
        ElseIf num == 4  
		   cPlaUsuAt4:=cPlanAtu
        ElseIf num == 5  
		   cPlaUsuAt5:=cPlanAtu
        EndIf
     EndIf   
    
    ElseIf trim(nTpAutor) == "RDA"     
     BAU->(DbSetOrder(4))
     If BAU->(DbSeek(xFilial("BAU")+SUBSTR(cons,1,14)))   
        baucodsa2:=BAU->BAU_CODSA2
     else                         
        cba1codpla:=' '
        cba1nome:=' '
        ba1cpf  :=' '
     EndIf     

       If num == 1                    
       
		  cIdentAut1:= substr(cons,1,14) 
		  cDescAut1 := substr(cons,15,40)
		  cPlaUsuAt1:= "RDA"
		  cPlaUsuOr1:= "RDA"
		  cForCli1  := baucodsa2
       
       ElseIf num == 2                  
       
		  cIdentAut2:= substr(cons,1,14) 
		  cDescAut2 := substr(cons,15,40)
		  cPlaUsuAt2:= "RDA"
		  cPlaUsuOr2:= "RDA"
		  cForCli2 := baucodsa2
       
       ElseIf num == 3 
       
		  cIdentAut3:= substr(cons,1,14) 
		  cDescAut3 := substr(cons,15,40)
		  cPlaUsuAt3:= "RDA"
		  cPlaUsuOr3:= "RDA"
		  cForCli3  := baucodsa2
		  
       ElseIf num == 4   
       
		  cIdentAut4:= substr(cons,1,14) 
		  cDescAut4 := substr(cons,15,40)
		  cPlaUsuAt4:= "RDA"
		  cPlaUsuOr4:= "RDA"
		  cForCli4  := baucodsa2
		  
       ElseIf num == 5  

		  cIdentAut5:= substr(cons,1,14) 
		  cDescAut5 := substr(cons,15,40)
		  cPlaUsuAt5:= "RDA"
		  cPlaUsuOr5:= "RDA"
		  cForCli5  := baucodsa2
		        
       EndIf
    
    ElseIf trim(nTpAutor) == "Colaborador"   
       If num == 1 
		  cIdentAut1:=SUBSTR(cons,1,11) 
		  cDescAut1 :=SUBSTR(cons,12,30)
		  cPlaUsuAt1:= "Colaborador"
		  cPlaUsuOr1:= "Colaborador"
		  cForCli1  :=SUBSTR(cons,43,6)
       ElseIf num == 2 
          cIdentAut2:=SUBSTR(cons,1,11) 
		  cDescAut2 :=SUBSTR(cons,12,30)
		  cPlaUsuAt2:= "Colaborador"
		  cPlaUsuOr2:= "Colaborador"
		  cForCli2  :=SUBSTR(cons,43,6)
       
       ElseIf num == 3 
          cIdentAut3:=SUBSTR(cons,1,11) 
		  cDescAut3 :=SUBSTR(cons,12,30)
		  cPlaUsuAt3:= "Colaborador"
		  cPlaUsuOr3:= "Colaborador"
		  cForCli3  :=SUBSTR(cons,43,6)
		  
      ElseIf num == 4  
        cIdentAut4:=SUBSTR(cons,1,11) 
		  cDescAut4 :=SUBSTR(cons,12,30)
		  cPlaUsuAt4:= "Colaborador"
		  cPlaUsuOr4:= "Colaborador"
		  cForCli4  :=SUBSTR(cons,43,6)
		  
       ElseIf num == 5  
          cIdentAut5:=SUBSTR(cons,1,11) 
		  cDescAut5 :=SUBSTR(cons,12,30)
		  cPlaUsuAt5:= "Colaborador"
		  cPlaUsuOr5:= "Colaborador"
		  cForCli5  :=SUBSTR(cons,43,6)
		  
       EndIf
    EndIf
return()      
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ desabilita reus e autores                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fbloqRA()

 /*  area do autor */      
       oCBox1:Disable()
       oCBox2:Disable()   
       oDtDist:Disable()
       oDtRec:Disable()
       oHoraRec:Disable() 
 
       oIdentAut1:Disable() 
       oIdentAut2:Disable()
       oIdentAut3:Disable()
       oIdentAut4:Disable()
       oIdentAut5:Disable()   
       
       oPlaUsu1:Disable()    
       oPlaUsu2:Disable()   
       oPlaUsu3:Disable()   
       oPlaUsu4:Disable()   
       oPlaUsu5:Disable()   
                                   
       oEmpUsu1:Disable()   
       oEmpUsu2:Disable()   
       oEmpUsu3:Disable()   
       oEmpUsu4:Disable()   
       oEmpUsu5:Disable()   

       oGet13:Disable() 
       oGet14:Disable()
       oGet15:Disable()       
       oGet16:Disable()
       oGet17:Disable()      

       oDescAut11:Disable() 
       oDescAut21:Disable()
       oDescAut31:Disable()
       oDescAut41:Disable()     
       oDescAut51:Disable()
       
       oDescAut12:Disable() 
       oDescAut22:Disable()
       oDescAut32:Disable()
       oDescAut42:Disable()     
       oDescAut52:Disable()

       oDescAut13:Disable() 
       oDescAut23:Disable()
       oDescAut33:Disable()
       oDescAut43:Disable()     
       oDescAut53:Disable() 
       
       oDescAut14:Disable() 
       oDescAut24:Disable()
       oDescAut34:Disable()
       oDescAut44:Disable()     
       oDescAut54:Disable()
   
 /*  area do reu */      
 
 oTipoReus1:Disable() 
 /*
 oGet5:Disable() 
 oNomeReus1:Disable()
 oNomeReus2:Disable() 
 oNomeReus3:Disable()  
 oNomeReus4:Disable() 
 oCBox6:Disable()      
 oGet7:Disable()      
 oGet61:Disable()     
 oGet62:Disable()     
 oGet63:Disable()     
 oGet64:Disable()
 oCBox8:Disable()
 oGet19:Disable()     
 oGet81:Disable() 
 oGet82:Disable()     
 oGet83:Disable()     
 oGet84:Disable()     
 oCBox10:Disable()
 oGet21:Disable() 
 oGet201:Disable()    
 oGet202:Disable()    
 oGet203:Disable()    
 oGet204:Disable()    
 oGet205:Disable()    
 oGet206:Disable() 
*/
				return()

Static Function fdesbloqRa()

 /*  area do autor */      
	oCBox1:enable()
	oCBox2:enable()
	oDtDist:enable()
	oDtRec:enable()
	oHoraRec:enable()

	oIdentAut1:enable()
	oIdentAut2:enable()
	oIdentAut3:enable()
	oIdentAut4:enable()
	oIdentAut5:enable()

	oPlaUsu1:enable()
	oPlaUsu2:enable()
	oPlaUsu3:enable()
	oPlaUsu4:enable()
	oPlaUsu5:enable()

	oEmpUsu1:enable()
	oEmpUsu2:enable()
	oEmpUsu3:enable()
	oEmpUsu4:enable()
	oEmpUsu5:enable()

	oGet13:enable()
	oGet14:enable()
	oGet15:enable()
	oGet16:enable()
	oGet17:enable()

	oDescAut11:enable()
	oDescAut21:enable()
	oDescAut31:enable()
	oDescAut41:enable()
	oDescAut51:enable()

	oDescAut12:enable()
	oDescAut22:enable()
	oDescAut32:enable()
	oDescAut42:enable()
	oDescAut52:enable()

	oDescAut13:enable()
	oDescAut23:enable()
	oDescAut33:enable()
	oDescAut43:enable()
	oDescAut53:enable()

	oDescAut14:enable()
	oDescAut24:enable()
	oDescAut34:enable()
	oDescAut44:enable()
	oDescAut54:enable()

 /*  area do reu */      

	oTipoReus1:enable()
	oGet5:enable()
	oNomeReus1:enable()
	oNomeReus2:enable()
	oNomeReus3:enable()
	oNomeReus4:enable()
	oNomeReus5:enable()
	oCBox6:enable()
	oGet7:enable()
	oGet61:enable()
	oGet62:enable()
	oGet63:enable()
	oGet64:enable()
	oGet65:enable()
	oCBox8:enable()
	oGet19:enable()
	oGet81:enable()
	oGet82:enable()
	oGet83:enable()
	oGet84:enable()
	oGet85:enable()
	oCBox10:enable()
	oGet21:enable()
	oGet201:enable()
	oGet202:enable()
	oGet203:enable()
	oGet204:enable()
	oGet205:enable()
	oGet206:enable()

return()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validar Codigo do CEP e alimenta os campos de endereço              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fConsulCEP(cCEP)

	If !Empty(cCEP)
		dbselectarea("BC9")
		dbsetorder(1)
		If dbseek(xFilial("BC9")+substr(cCEP,1,5)+substr(cCEP,7,3))
			cEndVara:= bc9_end
			cBairVara:= bc9_bairro
			cMunVara:=bc9_mun
			cUfVara:=bc9_est
			//cComarca:= bC9_codmun
		Else
			MsgAlert("O Cep Informado , "+cCep+" não Existe na base de dados ! Verifique.","Atencao!")
		endIf
	EndIf
Return()

//***************************************
// Faz desdobramento 
//*************************************

Static Function fdesdob()
	lsair :=.F.
	fGravareg()
	oGet3:enable()
	oGet3:SetFocus()
	lDesdob   := .T.

	nopcm := 3
	nopc  := 3


	fdesbloqRa()

Return()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Valida complemento                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function fValComp()

	If empty(cNumComPr)
		MsgAlert("O Complemento esta em Branco, favor preencher .","Atencao!")
		oGet3:SetFocus()
/*Else
   	dbselectarea("PBW")
	PBW->(DbSetOrder(1))
	dbSeek(xFilial("PBW")+str(cNumCab,6,0)+cNumproc+cNumComPr)             
    If Found()
      	msgBox("Desdobramento  já existe na base" ,"Não pode ser incluido , se necessario Informar Numero correto do Desdobramento !","INFO")
    EndIf     */
EndIf
    
 Return()   

/*
*/
Static Function fValproce()
	local ret:=.T.
	local cAliastmp      := GetNextAlias()
	Private cQuery       := " "
	cQuery := "select Count(*) qtda "
	cQuery += CRLF+ " from  " + RetSqlName("PBW") +" PBW "
	cQuery += CRLF+ " where PBW_filial = '"+xFilial('PBW')+ "' and PBW.d_E_L_E_T_ = ' ' "
	cQuery += CRLF+ " AND PBW_PROCES ='"+ cNumproc  +"' "
	cQuery += CRLF+ " AND PBW_NUMCOM ='"+ cNumComPr +"' "

	If Select((cAliastmp)) <> 0
		(cAliastmp)->(DbCloseArea())
	Endif

	TCQuery cQuery New Alias (cAliastmp)
	If (cAliastmp)->qtda > 0
		msgBox("Numero de Processo e Desdobramento  já existe na base" ,"Não pode ser incluido , se necessario Informar Numero correto do Processo e/ou Desdobramento !","INFO")
		oGet1:SetFocus()
		ret:=.F.
	EndIf

Return(ret)

Static Function fMovArqVar()

	cNumCab    := PBW->PBW_NUMPRO
	cNumproc   := PBW->PBW_PROCES
	cNumComPr  := PBW->PBW_NUMCOM

	cNCab411   := cNumCab
	cNproc411  := cNumproc
	cNCompP411 := cNumComPr

	nTpAutor   := PBW->PBW_TPAUTO
	nTpProc    := PBW->PBW_TPACAO
	dDtDist    := PBW->PBW_DTDIST
	dDtRec     := PBW->PBW_DTRECB
	cHoraRec   := PBW->PBW_HRRECB
	dDtArq     := PBW->PBW_DTARQ
	nAsProc    := PBW->PBW_ASSPRO
	cDescProc  := PBW->PBW_DESPRO

	aProcFor := JustificaTxt(PBW->PBW_DESPRO, 100)

	nDanMora   := PBW->PBW_DNMRSN
	nDanMat    := PBW->PBW_DNMTSN
	Ccc1       := PBW->PBW_CCT1
	Ccc2       := PBW->PBW_CCT2
	Ccc3       := PBW->PBW_CCT3
	Ccc4       := PBW->PBW_CCT4
	Ccc5       := PBW->PBW_CCT5
	nVlrmoral  := PBW->PBW_VLDNMR

	nVlrEsc    := PBW_VLRESC

	nVlrMat    := PBW->PBW_VLDNMT
	nVlrProc   := PBW->PBW_VLRCAU
	lEmail1    := PBW->PBW_EMCCT1
	lEmail2    := PBW->PBW_EMCCT2
	lEmail3    := PBW->PBW_EMCCT3
	lEmail4    := PBW->PBW_EMCCT4
	lEmail5    := PBW->PBW_EMCCT5
	lOrigem1   := PBW->PBW_ORCAU1
	lOrigem2   := PBW->PBW_ORCAU2
	lOrigem3   := PBW->PBW_ORCAU3
	lOrigem4   := PBW->PBW_ORCAU4
	lOrigem5   := PBW->PBW_ORCAU5
	cCodVara   := PBW->PBW_CODVAR
	cEndVara   := PBW->PBW_ENDVAR
	cNumvara   := PBW->PBW_NUMVAR
	nIdentVara := PBW->PBW_TIPVAR
	cBairVara  := PBW->PBW_BROVAR
	cMunVara   := PBW->PBW_MUNVAR
	cUfVara    := PBW->PBW_UFVARA
	cCep       := PBW->PBW_CEPVAR
	nTipoReus1 := ALLTRIM(PBW->PBW_TPREU1)
	nTipoReus2 := ALLTRIM(PBW->PBW_TPREU2)
	nTipoReus3 := ALLTRIM(PBW->PBW_TPREU3)
	nTipoReus4 := ALLTRIM(PBW->PBW_TPREU4)
	cCpfCnpj1  := PBW->PBW_CPCGR1
	cCpfCnpj2  := PBW->PBW_CPCGR2
	cCpfCnpj3  := PBW->PBW_CPCGR3
	cCpfCnpj4  := PBW->PBW_CPCGR4
	cNomeReus1 := PBW->PBW_NOMRE1
	cNomeReus2 := PBW->PBW_NOMRE2
	cNomeReus3 := PBW->PBW_NOMRE3
	cNomeReus4 := PBW->PBW_NOMRE4
	cIdentAut1 := PBW->PBW_IDAUT1
	cIdentAut2 := PBW->PBW_IDAUT2
	cIdentAut3 := PBW->PBW_IDAUT3
	cIdentAut4 := PBW->PBW_IDAUT4
	cIdentAut5 := PBW->PBW_IDAUT5
	cDescAut1  := PBW->PBW_NOMAU1
	cDescAut2  := PBW->PBW_NOMAU2
	cDescAut3  := PBW->PBW_NOMAU3
	cDescAut4  := PBW->PBW_NOMAU4
	cDescAut5  := PBW->PBW_NOMAU5
	cPlaUsuAt1 := PBW->PBW_PLATA1
	cPlaUsuAt2 := PBW->PBW_PLATA2
	cPlaUsuAt3 := PBW->PBW_PLATA3
	cPlaUsuAt4 := PBW->PBW_PLATA4
	cPlaUsuAt5 := PBW->PBW_PLATA5
	cPlaUsuOr1 := PBW->PBW_PLANT1
	cPlaUsuOr2 := PBW->PBW_PLANT2
	cPlaUsuOr3 := PBW->PBW_PLANT3
	cPlaUsuOr4 := PBW->PBW_PLANT4
	cPlaUsuOr5 := PBW->PBW_PLANT5
	cForCli1   := PBW->PBW_CLFOR1
	cForCli2   := PBW->PBW_CLFOR2
	cForCli3   := PBW->PBW_CLFOR3
	cForCli4   := PBW->PBW_CLFOR4
	cForCli5   := PBW->PBW_CLFOR5
	nComTut    := PBW->PBW_TUTCSN
	nSusTut    := PBW->PBW_TUTSSN
	dDtCumpTut := PBW->PBW_DTCPTU
	cHoraCump  := PBW->PBW_HRCPTU
	cDescTut   := PBW->PBW_DESTUT
	cSent1     := PBW->PBW_DSCSE1
	nTpSent1   := PBW->PBW_TPSEN1
	dDtSent1   := PBW->PBW_DTSEN1
	cSent2     := PBW->PBW_DSCSE2
	nTpSent2   := PBW->PBW_TPSEN2
	dDtsent2   := PBW->PBW_DTSEN2
	nAcaoTut1  := PBW->PBW_ACTUT1
	nAcaoTut2  := PBW->PBW_ACTUT2
	nAcaoTut3  := PBW->PBW_ACTUT3
	nAcaoTut4  := PBW->PBW_ACTUT4
	nAcaoTut5  := PBW->PBW_ACTUT5
	nAcao1in1:= PBW->PBW_ACSE11
	nAcao1in2:= PBW->PBW_ACSE12
	nAcao1in3:= PBW->PBW_ACSE13
	nAcao1in4:= PBW->PBW_ACSE14
	nAcao1in5:= PBW->PBW_ACSE15
	nAcao2in1:= PBW->PBW_ACSE21
	nAcao2in2:= PBW->PBW_ACSE22
	nAcao2in3:= PBW->PBW_ACSE23
	nAcao2in4:= PBW->PBW_ACSE24
	nAcao2in5:= PBW->PBW_ACSE25
	nStatus  := PBW->PBW_STATUS
	nTema    := trim(PBW->PBW_TEMA)
	cTemaEd  := nTema
	cStatusANS := nStatus
	nEAdvog  := PBW->PBW_ESCADV


Return()

Static Function fGrava()
	oDlg1:End()
Return()

Static Function fMovVarArq()
	PBW_FILIAL := xFILIAL("PBW")
	PBW_NUMPRO := cNumCab

	PBW_NUMPR1 := StrZero(cNumCab,6,0)

	PBW_PROCES := cNumproc
	PBW_NUMCOM := cNumComPr
	PBW_TPAUTO := nTpAutor
	PBW_TPACAO := nTpProc
	PBW_DTDIST := dDtDist
	PBW_DTRECB := dDtRec
	PBW_HRRECB := cHoraRec
	PBW_DTARQ  := dDtArq
	PBW_ASSPRO := nAsProc
	PBW_DESPRO := cDescProc

	aProcFor := JustificaTxt(	cDescProc, 100)

	PBW_DNMRSN := nDanMora
	PBW_DNMTSN := nDanMat
	PBW_CCT1   := Ccc1
	PBW_CCT2   := Ccc2
	PBW_CCT3   := Ccc3
	PBW_CCT4   := Ccc4
	PBW_CCT5   := Ccc5
	PBW_VLDNMR := nVlrmoral

	PBW_VLRESC := nVlrEsc

	PBW_VLDNMT := nVlrMat
	PBW_VLRCAU := nVlrProc
	PBW_EMCCT1 := lEmail1
	PBW_EMCCT2 := lEmail2
	PBW_EMCCT3 := lEmail3
	PBW_EMCCT4 := lEmail4
	PBW_EMCCT5 := lEmail5
	PBW_ORCAU1 := lOrigem1
	PBW_ORCAU2 := lOrigem2
	PBW_ORCAU3 := lOrigem3
	PBW_ORCAU4 := lOrigem4
	PBW_ORCAU5 := lOrigem5
	PBW_CODVAR := cCodVara
	PBW_ENDVAR := cEndVara
	PBW_NUMVAR := cNumvara
	PBW_TIPVAR := nIdentVara
	PBW_BROVAR := cBairVara
	PBW_MUNVAR := cMunVara
	PBW_UFVARA := cUfVara
	PBW_CEPVAR := cCep
	PBW_TPREU1 := nTipoReus1
	PBW_TPREU2 := nTipoReus2
	PBW_TPREU3 := nTipoReus3
	PBW_TPREU4 := nTipoReus4
	PBW_CPCGR1 := cCpfCnpj1
	PBW_CPCGR2 := cCpfCnpj2
	PBW_CPCGR3 := cCpfCnpj3
	PBW_CPCGR4 := cCpfCnpj4
	PBW_NOMRE1 := cNomeReus1
	PBW_NOMRE2 := cNomeReus2
	PBW_NOMRE3 := cNomeReus3
	PBW_NOMRE4 := cNomeReus4
	PBW_IDAUT1 := cIdentAut1
	PBW_IDAUT2 := cIdentAut2
	PBW_IDAUT3 := cIdentAut3
	PBW_IDAUT4 := cIdentAut4
	PBW_IDAUT5 := cIdentAut5
	PBW_NOMAU1 := cDescAut1
	PBW_NOMAU2 := cDescAut2
	PBW_NOMAU3 := cDescAut3
	PBW_NOMAU4 := cDescAut4
	PBW_NOMAU5 := cDescAut5
	PBW_PLATA1 := cPlaUsuAt1
	PBW_PLATA2 := cPlaUsuAt2
	PBW_PLATA3 := cPlaUsuAt3
	PBW_PLATA4 := cPlaUsuAt4
	PBW_PLATA5 := cPlaUsuAt5
	PBW_PLANT1 := cPlaUsuOr1
	PBW_PLANT2 := cPlaUsuOr2
	PBW_PLANT3 := cPlaUsuOr3
	PBW_PLANT4 := cPlaUsuOr4
	PBW_PLANT5 := cPlaUsuOr5
	PBW_CLFOR1 := cForCli1
	PBW_CLFOR2 := cForCli2
	PBW_CLFOR3 := cForCli3
	PBW_CLFOR4 := cForCli4
	PBW_CLFOR5 := cForCli5
	PBW_TUTCSN := nComTut
	PBW_TUTSSN := nSusTut
	PBW_DTCPTU := dDtCumpTut
	PBW_HRCPTU := cHoraCump
	PBW_DESTUT := cDescTut
	PBW_DSCSE1 := cSent1
	PBW_TPSEN1 := nTpSent1
	PBW_DTSEN1 := dDtSent1
	PBW_DSCSE2 := cSent2
	PBW_TPSEN2 := nTpSent2
	PBW_DTSEN2 := dDtsent2
	PBW_ACTUT1 := nAcaoTut1
	PBW_ACTUT2 := nAcaoTut2
	PBW_ACTUT3 := nAcaoTut3
	PBW_ACTUT4 := nAcaoTut4
	PBW_ACTUT5 := nAcaoTut5
	PBW_ACSE11 := nAcao1in1
	PBW_ACSE12 := nAcao1in2
	PBW_ACSE13 := nAcao1in3
	PBW_ACSE14 := nAcao1in4
	PBW_ACSE15 := nAcao1in5
	PBW_ACSE21 := nAcao2in1
	PBW_ACSE22 := nAcao2in2
	PBW_ACSE23 := nAcao2in3
	PBW_ACSE24 := nAcao2in4
	PBW_ACSE25 := nAcao2in5
	if !empty (nTema)
		PBW_TEMA   := trim(nTema)
	EndIf
	if !empty (nStatus)
		PBW_STATUS := nStatus
	Endif
	PBW_ESCADV := nEAdvog

//sleep(10000)

Return()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Formata textos das caixas multiget                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fformtxt(txt, Num)

	local ctxt := ''
	local x    := 1
	local y    := 1
	local atxt := {}

	If Empty(txt)
		ctxt:= txt
	else
		while x <= len(txt)
			if !(substr(txt ,x , 1) $ CRLF)
				ctxt+= substr(txt ,x , 1)
			endIf
			x++
		enddo
		atxt := JustificaTxt(ctxt, 60)
		ctxt :=''
		while Y <= LEN(atxt)
			If !empty(atxt[Y])
				ctxt += atxt[Y]+CRLF
			EndIf
			y++
		Enddo

	EndIF

Return(ctxt)
//// grava registros
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava registro                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function fGravaReg()

	dbselectarea("PBW")
	PBW->(DbSetOrder(1))
	dbSeek(xFilial("PBW")+str(cNumCab,6,0)+cNumproc+cNumComPr)
	if  nOpcm == 3 	 .or. lDesdob
		if   empty(cNumproc)
			msgBox("Numero Processo em Branco" ,"Não pode ser incluido , deve ser preenchido  !","INFO")
		elseIf  Found()
			msgBox("Processo já existe na base" ,"Não pode ser incluido , se necessario faça manutenção !","INFO")
		Else
			If fCriticas()
				If  _cEnvMail == 'S'
					fEnvEmail('INC')
				EndIf
				RecLock("PBW",.T.)
				fMovVarArq()
				Msunlock("PBW")

				fGrvSAdv()

				oDlg1:End()
			EndIf
		EndIf

	Else
		If  fCriticas()
			RecLock("PBW",.F.)
			fMovVarArq()
			Msunlock("PBW")

			If _cEnvMail == 'S'
				If  ApMsgYesNo("Deseja enviar email para esta alteração??","SIMNAO")
					fEnvEmail('ALT')
				EndIf
			EndIf

			//   fGrvSAdv()

			If lsair
				oDlg1:End()
			EndIf
		EndIf
	EndIf

return()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Formata textos das caixas multiget                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fEnvEmail(cOrigem )

	local cDest      := " "
	Local aArea      := GetArea() //Armazena a Area atual
	local cAssunto   := ' '
	Local _cMensagem := ""

	If cOrigem=="INC"
		cAssunto := 'Inclusao de processo'
		_cMensagem := Chr(13) + Chr(10) + Chr(13) + Chr(10) +" Assunto : Inclusao de processo, Numero : "
		_cMensagem +=  cNumproc  + ' - ' + cNumComPr
		_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ "Prezados ,  "
		_cMensagem +=  Chr(13) + Chr(10) + "Informamos que o processo acima Identificado foi INCLUIDO na data de "+ DtoC(dDtRec)+"  "
	ElseIf cOrigem=="ALT"
		cAssunto := 'Alteração de processo'
		_cMensagem :=  Chr(13) + Chr(10) + " Assunto : Alteração no processo , Numero : "
		_cMensagem +=  str(cNumCab,6,0)  + ' - ' + cNumproc  + ' - ' + cNumComPr
		_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ "Prezados ,  "
		_cMensagem +=  Chr(13) + Chr(10) + "Informamos que o processo acima Identificado foi ALTERADO na data de "+ DtoC( Date() )+"  "
	ElseIf cOrigem=="DEL"
		cAssunto := 'Exclusão de processo'
		_cMensagem :=  Chr(13) + Chr(10) + " Assunto : Exclusão do processo , Numero : "
		_cMensagem +=  str(cNumCab,6,0)  + ' - ' + cNumproc  + ' - ' + cNumComPr
		_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ "Prezados ,  "
		_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Informamos que o processo acima Identificado foi EXCLUIDO na data de "+ DtoC( Date() )+"  "
	EndIf
	_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Abaixo relatado  "
	_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ " Assunto : "+ nAsProc
	_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ " Teor  : "

	_cMensagem +=  Chr(13) + Chr(10) + FMNTEMAILA(2) //_cMenspro

	_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ " Tendo como Autor(es) o(s), " + nTpAutor+"(s)  : "
	_cMensagem +=  Chr(13) + Chr(10) + FMNTEMAILA(1)

	if !empty(cEmailCtt1)
		cDest+= cEmailCtt1
	EndIf
	if !empty(cEmailCtt2)
		cDest+=';'+cEmailCtt2
	EndIf
	if !empty(cEmailCtt3)
		cDest+=';'+cEmailCtt3
	EndIf
	if !empty(cEmailCtt4)
		cDest+=';'+cEmailCtt4
	EndIf
	if !empty(cEmailCtt5)
		cDest+=';'+cEmailCtt5
	EndIf
//_cMensagem +=   Chr(10) + Chr(13) + Chr(10) + Chr(13)+ Chr(10) + Chr(13) + Chr(10) + Chr(13)+"                    Rio de Janeiro , " +  DtoC( Date() )  

	ENVEMAIL1( _cMensagem , cDest , cAssunto)

	RestArea(aArea)

Return (.T.)
	*--------------------------------------*
static Function EnvEmail1( _cMensagem , cDest , cAssunt  , ccCC )
	*--------------------------------------*

/*Local _cMailServer := GetMv( "MV_WFSMTP" )
Local _cMailConta  := GetMv( "MV_WFAUTUS" )
Local _cMailSenha  := GetMv( "MV_WFAUTSE" )                        */
Local _cMailServer := GetMv( "MV_RELSERV" )
Local _cMailConta  := GetMv( "MV_EMCONTA")
Local _cMailSenha  := GetMv( "MV_EMSENHA" ) 

//Local _cTo  	   := "altamiro@caberj.com.br, paulovasques@caberj.com.br, piumbim@caberj.com.br"
Local _cTo  	   := trim(cDest) //"altamiro@caberj.com.br , carlaramos@caberj.com.br"  
Local _cCC         := " "//"fabiola.silva@caberj.com.br,carlaramos@caberj.com.br,paulahees.juridico@caberj.com.br"
//Local _cCC       := trim(GetMv( "MV_MLCPJU" ) ) nao esta carregando pelo paramentro ,

Local _cAssunto    := cAssunt //" Cadastro de processo  - email Automatico "
Local _cError      := ""
Local _lOk         := .T.
Local _lSendOk     := .F.

If !Empty(ccCC)

    _cCC:= ccCC

EndIf     
 
If !Empty( _cMailServer ) .And.    !Empty( _cMailConta  ) 
	// Conecta uma vez com o servidor de e-mails
	CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk
 
	If _lOk
		SEND MAIL From _cMailConta To _cTo CC _cCC   Subject _cAssunto Body _cMensagem  Result _lSendOk   
		//SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk
	Else
		//Erro na conexao com o SMTP Server
		GET MAIL ERROR _cError
     	Aviso( "Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )   
	EndIf

    If _lOk       
    	//Desconecta do Servidor
      	DISCONNECT SMTP SERVER  
    EndIf
EndIf
return()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ pega o proximo numero                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function fProxNum()
local ret:= 0
local cAliastmp      := GetNextAlias()  
Private cQuery       := " "   

cQuery := "select nvl(max(pbw_numpro), 0 ) NUMMAX "
cQuery += CRLF+ " from  " + RetSqlName("PBW") +" PBW "
cQuery += CRLF+ " where PBW_filial = '"+xFilial('PBW')+ "' and PBW.d_E_L_E_T_ = ' ' "  
                         

//dbSelectArea(cAliastmp)
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif                          

TCQuery cQuery New Alias (cAliastmp)   

    (cAliastmp)->( DbGoTop() )  
     ret:= ((cAliastmp)->NUMMAX+1)
	(cAliastmp)->(DbCloseArea())
			
Return( ret )


Static Function fLimVar()
	cNumCab    := 0
    cNumproc   := '                              '    
    cNumComPr  := ' ' 
    nTpAutor   := ' '
    nTpProc    := ' '
    dDtDist    := ' '
    dDtRec     := ' '
    cHoraRec   := ' '
    dDtArq     := ' '
    nAsProc    := ' '
    cDescProc  := ' '
    nDanMora   := ' '
    nDanMat    := ' '
    Ccc1       := ' '
    Ccc2       := ' '
    Ccc3       := ' '
    Ccc4       := ' '
    Ccc5       := ' '
    nVlrmoral  := ' '
    nVlrMat    := 0.00
    nVlrProc   := 0.00
    nVlrEsc    := 0.00
    lEmail1    := ' '
    lEmail2    := ' '
    lEmail3    := ' '
    lEmail4    := ' '
    lEmail5    := ' '
    lOrigem1   := ' '
    lOrigem2   := ' '
    lOrigem3   := ' '
    lOrigem4   := ' '
    lOrigem5   := ' '
    cCodVara   := ' '
    cEndVara   := ' '
    nIdentVara := ' '
    cNumvara   :=0
    cBairVara  := ' '
    cMunVara   := ' '
    cUfVara    := ' '
    cCep       := ' '
    nTipoReus1 := ' '
    nTipoReus2 := ' '
    nTipoReus3 := ' '
    nTipoReus4 := ' '
    cCpfCnpj1  := ' '
    cCpfCnpj2  := ' '
    cCpfCnpj3  := ' '
    cCpfCnpj4  := ' '
    cNomeReus1 := ' '
    cNomeReus2 := ' '
    cNomeReus3 := ' '
    cNomeReus4 := ' '
    cIdentAut1 := ' '
    cIdentAut2 := ' '
    cIdentAut3 := ' '
    cIdentAut4 := ' '
    cIdentAut5 := ' '
    cDescAut1  := ' '
    cDescAut2  := ' '
    cDescAut3  := ' '
    cDescAut4  := ' '
    cDescAut5  := ' '
    cPlaUsuAt1 := ' '
    cPlaUsuAt2 := ' '
    cPlaUsuAt3 := ' '
    cPlaUsuAt4 := ' '
    cPlaUsuAt5 := ' '
    cPlaUsuOr1 := ' '
    cPlaUsuOr2 := ' '
    cPlaUsuOr3 := ' '
    cPlaUsuOr4 := ' '
    cPlaUsuOr5 := ' '
    cForCli1   := ' '
    cForCli2   := ' '
    cForCli3   := ' '
    cForCli4   := ' '
    cForCli5   := ' '
    nComTut    := ' '
    nSusTut    := ' '
    dDtCumpTut := ' '
    cHoraCump  := ' '
    cDescTut   := ' '
    cSent1     := ' '
    nTpSent1   := ' '
    dDtSent1   := ' '
    cSent2     := ' '
    nTpSent2   := ' '
    dDtsent2   := ' '
    nAcaoTut1  := ' '
    nAcaoTut2  := ' '
    nAcaoTut3  := ' '
    nAcaoTut4  := ' '
    nAcaoTut5  := ' '
    nAcao1in1:= ' '
    nAcao1in2:= ' '
    nAcao1in3:= ' '
    nAcao1in4:= ' '
    nAcao1in5:= ' '
    nAcao2in1:= ' '
    nAcao2in2:= ' '
    nAcao2in3:= ' '
    nAcao2in4:= ' '
    nAcao2in5:= ' '
Return()
 
Static Function  fTratButao(nOpc)     
local nOpcM:= nOpc                  

if nOpcM == 3
   oGet2:Disable()     
   oGet3:Disable()
   oBtn2:Disable()
   oDesvaz:Disable()
   oBtn3:Disable()
   oBtn5:Disable()     
   oBtn6:Disable()     
   oGet2:refresh() 
   
elseif nOpcM == 1                                  
   oGet1:Disable() 
   oGet2:Disable()  
   oBtn1:Disable()   
   oGet3:Disable()
   oBtn2:Disable()
   oDesvaz:Disable()
   oBtn3:Disable()
   oBtn5:Disable() 
   oBtn6:Disable() 
elseif nOpcM == 2
   oGet1:Disable() 
   oGet2:Disable()  
   oGet3:Disable()   
   if !empty(cNumComPr)
       oBtn3:Disable()
   EndIf  
EndIf 

/*oBtn1      := TButton():New( 008,500,"Grava",oGrp13,{||fgrava()},048,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 022,500,"Deleta",oGrp13,,048,012,,,,.T.,,"",,,,.F. )
oDesvaz    := TButton():New( 008,584,"Ônus da Causa ",oGrp13,,053,012,,,,.T.,,"",,,,.F. )
oBtn4      := TButton():New( 036,500,"Sair",oGrp13,{||oDlg1:End()},048,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 036,584,"Desdobramentos",oGrp13,{ || oBtn3bAction },054,012,,,,.T.,,"",,,,.F. )
oBtn5      := TButton():New( 022,584,"And./Audien / Prazos",oGrp13,,054,012,,,,.T.,,"",,,,.F. )
*/

Return()

Static Function  fvlrcausa()
	nVlrProc:= nVlrmoral + nVlrMat
	oVlrProc:refresh()

	oCBox5:SetItems( aTema )

Return()

Static Function  ftutela(ctut)
	If ctut == 'Sim'
		dDtCumpTut := dDtRec
	EndIf
Return()


//  valida hora     

static function fValHora(nHora,_cHora)

	local ret:= .T.


	if  substr(STRZERO(nhora,4),1,2) >= '00' .and. substr(STRZERO(nhora,4,0),1,2) <= '23' .and. substr(STRZERO(nhora,4,0),3,2) >= '00' .and. substr(STRZERO(nhora,4,0),3,2) <= '59'
		ret:=.T.
	else
		ret:=.F.
		MsgAlert("Hora Invalida !!! ","Atencao!")
	endIf

return(ret)

/// valida campos - inclusao 

static  function fvalRA()
	local ret:= .T.
//If nTpProc $ "PROCESSO'
	if empty(cNomeReus1) .and. ;
			empty(cNomeReus2) .and. ;
			empty(cNomeReus3) .and. ;
			empty(cNomeReus4)
		ret:=.F.
		MsgAlert("Reu NÃO Preenchido  !!! , Preencha pelo menos um  Reu ","Atencao!")
	EndIf
	if empty(cIdentAut1) .and. ;
			empty(cIdentAut2) .and. ;
			empty(cIdentAut3) .and. ;
			empty(cIdentAut4) .and. ;
			empty(cIdentAut5)
		ret:=.F.
		MsgAlert("Autor NÃO Preenchido  !!! , Preencha pelo menos um  Autor ","Atencao!")
	EndIf
// EndIf      
return(ret)
//  valida data
static  function fValData(dDtinc , DdtFim , cobj)

	local ret:= .T.
	lCritHora :=.F.
	if cobj == 1
		If EMPTY(dDtinc)
			MsgAlert("Data de distribuição NÃO Esta Preenchida !!! ","Atencao!")
			ret:=.F.
		EndIf
		If EMPTY(dDtFim)
			MsgAlert("Data de Recebimento NÃO Esta Preenchida !!! ","Atencao!")
			ret:=.F.
		EndIf
		If dDtinc > ddatatu
			MsgAlert("Data de distribuição Maior que Data atual !!! ","Atencao!")
			ret:=.F.
		EndIf
		If dDtFim > ddatatu
			MsgAlert("Data de Recebimento Maior que Data atual !!! ","Atencao!")
			ret:=.F.
		EndIf
	Else
		If dDtFim > ddatatu
			MsgAlert("Data de Arquivamento Maior que Data atual !!! ","Atencao!")
			ret:=.F.
		EndIf
	EndIf

	If ret
		if  dtos(DdtFim) >= dtos(dDtinc) .or. empty(DdtFim)
			ret:=.T.
		Else
			ret:=.F.
			lCritHora :=.T.
			if cobj == 1
				MsgAlert("Data de distribuição maior que a Data de recepção !!! ","Atencao!")
			Elseif cobj == 2
				MsgAlert("Data de Arquivamento  maior que a Data de recepção !!! ","Atencao!")
			EndIf
		EndIf
	EndIf

return(ret)

static  function fCriticas()
	local ret:= .T.
	If !fValHora(cHoraRec)
		oHoraRec:setfocus()
		ret:= .F.
	EndiF

	If !(fValData(dDtDist, dDtRec , 1 ))
		oDtRec:setfocus()
		ret:= .F.
	EndIf
	If !(fValData(dDtRec,dDtArq , 2 ))
		oGet11:setfocus()
		ret:= .F.
	EndIf
	If nOpcm  == 3
		ret:= fValproce()
		ret:= fValRA()
	endIf

	if cEmpresa = 'C'
		if (trim(nTipoReus1) == 'INTEGRAL' .or. trim(nTipoReus2) == 'INTEGRAL')  .and. ;
				(trim(nTipoReus1) != 'CABERJ'   .and. trim(nTipoReus2) != 'CABERJ')
			msgBox( "Processo Na CABERJ , mas só a INTEGRAL é Reu  !","Processo Na CABERJ ","INFO")
			oTipoReus1:SetFocus()
			ret:= .F.
		EndIf
	Elseif cEmpresa = 'I'
		if (trim(nTipoReus1) == 'CABERJ' .or.  trim(nTipoReus2) == 'CABERJ') .and. ;
				(trim(nTipoReus1) != 'INTEGRAL' .and. trim(nTipoReus2) != 'INTEGRAL')
			msgBox("Processo Na INTEGRAL , mas só a CABERJ  é Reu  !","Processo Na INTEGRAL " ,"INFO")
			oTipoReus1:SetFocus()
			ret:= .F.
		EndIf
	EndIf

return(ret)


static function banco_email()

	cMensagem :='Recebemos no dia '+dDtRec+' ,  tipo processo '+ nTpProc
	cMensagem += Chr(13) + Chr(10) + "Solicitamos encaminhamento de relato detalhado e subsídios documentais para confecção de defesa.
	cMensagem +=Chr(13) + Chr(10) + " Assunto : "+ nAsProc
	cMensagem +=  Chr(13) + Chr(10) + cDescProc
	cMensagem +=Chr(13) + Chr(10) + " Prazo de retorno no dia __/__/__

	cMensagem +=Chr(13) + Chr(10) + " Prezado Felipe,
	cMensagem +=Chr(13) + Chr(10) + "   Para ciência e providências.
	cMensagem +=Chr(13) + Chr(10) + "   Prazo de retorno de escritório no dia __/__/__
	cMensagem +=Chr(13) + Chr(10) + "   Atenciosamente,
	cMensagem +=Chr(13) + Chr(10) + "   Jurídico
	cMensagem +=Chr(13) + Chr(10) + "  R:6591 / R:9807

	_cMensagem +=  Chr(13) + Chr(10) + " Solicitamos encaminhamento de relato detalhado e subsídios documentais para confecção de defesa."
	_cMensagem +=  Chr(13) + Chr(10) + " Assunto : "+ nAsProc
	_cMensagem +=  Chr(13) + Chr(10) + cDescProc
	_cMensagem +=  Chr(13) + Chr(10) +  " Prazo de retorno no dia __/__/__ "
	_cMensagem +=  Chr(13) + Chr(10) +  " Prezado Felipe, "
	_cMensagem +=  Chr(13) + Chr(10) +  " Para ciência e providências. "
	_cMensagem +=  Chr(13) + Chr(10) +  " Prazo de retorno de escritório no dia __/__/__ "
	_cMensagem +=  Chr(13) + Chr(10) +  " Atenciosamente, "
	_cMensagem +=  Chr(13) + Chr(10) +  " Jurídico "
	_cMensagem +=  Chr(13) + Chr(10) +  " R:6591 / R:9807 "


return(cMensagem)

static Function fGrvSAdv()

	LOCAL cCod         := '000'

	If trim(PBW->PBW_TPAUTO) == 'Beneficiario'

		FBUSUSUAR11(PBW->PBW_IDAUT1)

		If !empty((cAliastmp1)->Matric)

//    	If ApMsgYesNo("Confirma Lançamento de Situação Adversa para o usuario "+(cAliastmp1)->NomUsr+" ","SIMNAO")

			Do Case
			Case	(trim(pbw->pbw_tpacao) =='ALERJ' .AND. cEmpAnt == '01')
				cCod := '004'
			Case	(trim(substr(pbw->pbw_tpacao,1,3)) =='ANS' .AND. cEmpAnt == '01')
				cCod :=	'011'
			Case	(trim(pbw->pbw_tpacao) =='DECON' .AND. cEmpAnt == '01')
				cCod := '004'
			Case	(trim(pbw->pbw_tpacao) =='MINISTERIO PUBLICO'.AND. cEmpAnt == '01')
				cCod := '004'
			Case	(trim(pbw->pbw_tpacao) =='PROCESSO CIVEL' .AND. cEmpAnt == '01')
				cCod := '005'
			Case	(trim(pbw->pbw_tpacao) =='PROCESSO CRIMINAL' .AND. cEmpAnt == '01')
				cCod := '005'
			Case	(trim(pbw->pbw_tpacao) =='PROCESSO TRABALHISTA' .AND. cEmpAnt == '01')
				cCod := '005'
			Case	(trim(pbw->pbw_tpacao) =='PROCESSO TRIBUTARIO' .AND. cEmpAnt == '01')
				cCod := '005'
			Case	(trim(pbw->pbw_tpacao) =='PROCON' .AND. cEmpAnt == '01')
				cCod := '015'
			Case	(trim(pbw->pbw_tpacao) =='RECEITA FEDERAL' .AND. cEmpAnt == '01')
				cCod := '004'
			Case	(trim(pbw->pbw_tpacao) =='ALERJ' .AND. cEmpAnt == '02')
				cCod := '004'
			Case	(trim(substr(pbw->pbw_tpacao,1,3)) =='ANS' .AND. cEmpAnt == '02')
				cCod :=	'014'
			Case	(trim(pbw->pbw_tpacao) =='DECON' .AND. cEmpAnt == '02')
				cCod := '004'
			Case	(trim(pbw->pbw_tpacao) =='MINISTERIO PUBLICO'.AND. cEmpAnt == '02')
				cCod := '004'
			Case	(trim(pbw->pbw_tpacao) =='PROCESSO CIVEL' .AND. cEmpAnt == '02')
				cCod := '005'
			Case	(trim(pbw->pbw_tpacao) =='PROCESSO CRIMINAL' .AND. cEmpAnt == '02')
				cCod := '005'
			Case	(trim(pbw->pbw_tpacao) =='PROCESSO TRABALHISTA' .AND. cEmpAnt == '02')
				cCod := '005'
			Case	(trim(pbw->pbw_tpacao) =='PROCESSO TRIBUTARIO' .AND. cEmpAnt == '02')
				cCod := '005'
			Case	(trim(pbw->pbw_tpacao) =='PROCON' .AND. cEmpAnt == '02')
				cCod := '013'
			Case	(trim(pbw->pbw_tpacao) =='RECEITA FEDERAL' .AND. cEmpAnt == '02')
				cCod := '004'
			Case	trim(pbw->pbw_tpacao) =='OUTROS'
				cCod := '000'
			Otherwise
				cCod := '000'
			EndCase

			RecLock("BHH",.T.)

			BHH_FILIAL := xFilial("BHH")
			BHH_CODINT := '0001'
			BHH_CODEMP := (cAliastmp1)->CodEmp
			BHH_MATRIC := (cAliastmp1)->Matric
			BHH_TIPREG := (cAliastmp1)->Tipreg
			BHH_CODSAD := cCod
			BHH_OBS1   := 'Tipo da Ação : ' + PBW->PBW_TPACAO
			BHH_OBS2   := 'Num Processo : ' + PBW->PBW_PROCES
			BHH_OBS3   := 'Num Complem  : ' + PBW->PBW_NUMCOM
			BHH_OBS4   := 'Assunto : ' + PBW->PBW_ASSPRO
			BHH_OBS5   := ' '
			BHH_OBS6   := ' '
			BHH_OBS7   := ' '
			BHH_OBS8   := ' '
			BHH_OBS9   := ' '
			BHH_OBS10  := ' '
			BHH_OBS11  := ' '
			BHH_OBS12  := 'Num Caberj : ' + STR(PBW->PBW_NUMPRO)

			BHH_VIGDE  := PBW->PBW_DTRECB
			BHH_VIGATE := PBW->PBW_DTARQ

			Msunlock("BHH")
			//   EndIf
		Else

			MsgAlert("Beneficiario NÃO Encontrado , Situação Adversa devera ser cadastrada manualmente .","Atencao!")

		EndIf
	EndIf
Return()

static  Function fbususuar11(cCpfUsr)

	LOCAL cQuery       := " "

	cQuery := " select ba1_codemp Codemp , ba1_matric Matric , ba1_tipreg Tipreg , BA1_NOMUSR NomUsr , ba1_tipusu TpUsuar , "
	cQuery += CRLF + " ba1_datnas Dtnasc , BA1_datinc DtInc  , ba1_datblo DtBloq , ba1_motblo MotBlo , ba1_codcco CodCCo  , "
	cQuery += CRLF + " ba1_codpla CodPla , bi3_descri DesPla , "
	cQuery += CRLF + " decode(TRIM(BA1.BA1_IMAGE),'ENABLE', 'ATIVO', 'INATIVO') Sitac , "
	cQuery += CRLF + " NVL(BG3.BG3_DESBLO, ' ') DesBloq  , NVL(BG9_CODIGO,' ') CODEMP , NVL(BG9_DESCRI,' ') NOMEMP  , NVL(BI3_SUSEP,' ') SUSEP "
	cQuery += CRLF + " FROM  " + RetSqlName("BA1") +" BA1 , "  + RetSqlName("BI3") +" BI3 , " + RetSqlName("BG3") +" BG3 , "
	cQuery += CRLF + "       " + RetSqlName("BG9") +" BG9 "
	cQuery += CRLF + " WHERE  BA1_filial = '"+xFilial('BA1')+ "' and BA1.d_E_L_E_T_ = ' ' "
	cQuery += CRLF + "   and BI3_filial = '"+xFilial('BI3')+ "' and Bi3.d_E_L_E_T_ = ' ' "
	cQuery += CRLF + "   and BG3_filial(+) = '"+xFilial('BG3')+ "' and BG3.d_E_L_E_T_(+) = ' ' "
	cQuery += CRLF + "   and BG9_filial(+) = '"+xFilial('BG9')+ "' and BG9.d_E_L_E_T_(+) = ' ' "
	cQuery += CRLF + "   AND BA1_MOTBLO = BG3_CODBLO(+) "

	cQuery += CRLF + "   AND BA1_codemp  = BG9_CODIGO(+) "

	cQuery += CRLF + "   AND ba1_codpla   = BI3_CODIGO(+)
	cQuery += CRLF + "   AND BI3_CODINT(+)= '0001'
	cQuery += CRLF + "   AND ba1_versao   = BI3_VERSAO(+)

	cQuery += CRLF + "   AND ba1_datinc = (select max(ba1_datinc) from  " + RetSqlName("BA1") +" BA11
	cQuery += CRLF + "                      Where BA1_filial = '"+xFilial('BA1')+ "' and BA11.d_E_L_E_T_ = ' ' AND BA1_CPFUSR = '"+cCpfUsr+"' )"

	cQuery += CRLF+ "    AND BA1_CPFUSR = '"+cCpfUsr+"' "

	If Select((cAliastmp1)) <> 0
		(cAliastmp1)->(DbCloseArea())
	Endif

	TCQuery cQuery New Alias (cAliastmp1)

	(cAliastmp1)->( DbGoTop() )

Return()

/******************************************/ 

static function FMNTEMAILA( ident )

	local x := 0

	if ident == 1
		If trim(nTpAutor) == 'Beneficiario'

			If cDescAut1 <> ' '

				FBUSUSUAR11(cIdentAut1)

				If Select((cAliastmp1)) <> 0

					_cMensAut:= Chr(13) + Chr(10) + Chr(13) + Chr(10) +  "Dados do Beneficiário: " + cDescAut1

					_cMensAut += Chr(13) + Chr(10) +  "Plano: " +(cAliastmp1)->CodPla + ' - ' +  (cAliastmp1)->DesPla
					_cMensAut += Chr(13) + Chr(10) +  "Empresa: " +(cAliastmp1)->CODEMP+' - ' +(cAliastmp1)->NOMEMP
					_cMensAut += Chr(13) + Chr(10) +  "Registro Plano: "+(cAliastmp1)->SUSEP
					_cMensAut += Chr(13) + Chr(10) +  "CCO: " +(cAliastmp1)->CodCCo
					_cMensAut += Chr(13) + Chr(10) +  "Data Inclusão: " + substr((cAliastmp1)->DtInc,7,2)+'/'+substr((cAliastmp1)->DtInc,5,2)+'/'+substr((cAliastmp1)->DtInc,1,4)
					_cMensAut += Chr(13) + Chr(10) +  "Data Exclusão: " + substr((cAliastmp1)->DtBloq,7,2)+'/'+substr((cAliastmp1)->DtBloq,5,2)+'/'+substr((cAliastmp1)->DtBloq,1,4)

				EndIf

			ElseIf cDescAut2 <> ' '

				_cMensAut +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) +  "Autor 2 : " + cDescAut2

				FBUSUSUAR11(cIdentAut2)

				If Select((cAliastmp1)) <> 0

					_cMensAut += Chr(13) + Chr(10) +  "Plano: " + (cAliastmp1)->CodPla + ' - ' +  (cAliastmp1)->DesPla
					_cMensAut += Chr(13) + Chr(10) +  "CCO: " +(cAliastmp1)->CodCCo
					_cMensAut += Chr(13) + Chr(10) +  "Data Inclusão: " + substr((cAliastmp1)->DtInc,7,2)+'/'+substr((cAliastmp1)->DtInc,5,2)+'/'+substr((cAliastmp1)->DtInc,1,4)
					_cMensAut += Chr(13) + Chr(10) +  "Data Exclusão: " + substr((cAliastmp1)->DtBloq,7,2)+'/'+substr((cAliastmp1)->DtBloq,5,2)+'/'+substr((cAliastmp1)->DtBloq,1,4)

				EndIf

			ElseIf cDescAut3 <> ' '

				_cMensAut +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) +  "Autor 3: " + cDescAut3

				FBUSUSUAR11(cIdentAut3)

				If Select((cAliastmp1)) <> 0

					_cMensAut += Chr(13) + Chr(10) +  "Plano: " + (cAliastmp1)->CodPla + ' - ' +  (cAliastmp1)->DesPla
					_cMensAut += Chr(13) + Chr(10) +  "CCO: " +(cAliastmp1)->CodCCo
					_cMensAut += Chr(13) + Chr(10) +  "Data Inclusão: " + substr((cAliastmp1)->DtInc,7,2)+'/'+substr((cAliastmp1)->DtInc,5,2)+'/'+substr((cAliastmp1)->DtInc,1,4)
					_cMensAut += Chr(13) + Chr(10) +  "Data Exclusão: " + substr((cAliastmp1)->DtBloq,7,2)+'/'+substr((cAliastmp1)->DtBloq,5,2)+'/'+substr((cAliastmp1)->DtBloq,1,4)

				EndIf

			ElseIf cDescAut4 <> ' '

				_cMensAut +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) +  "Autor 4 : " + cDescAut4

				FBUSUSUAR11(cIdentAut4)

				If Select((cAliastmp1)) <> 0

					_cMensAut += Chr(13) + Chr(10) +  "Plano: " + (cAliastmp1)->CodPla + ' - ' +  (cAliastmp1)->DesPla
					_cMensAut += Chr(13) + Chr(10) +  "CCO: " +(cAliastmp1)->CodCCo
					_cMensAut += Chr(13) + Chr(10) +  "Data Inclusão: " + substr((cAliastmp1)->DtInc,7,2)+'/'+substr((cAliastmp1)->DtInc,5,2)+'/'+substr((cAliastmp1)->DtInc,1,4)
					_cMensAut += Chr(13) + Chr(10) +  "Data Exclusão: " + substr((cAliastmp1)->DtBloq,7,2)+'/'+substr((cAliastmp1)->DtBloq,5,2)+'/'+substr((cAliastmp1)->DtBloq,1,4)

				EndIf

			ElseIf cDescAut5 <> ' '

				_cMensAut += Chr(13) + Chr(10) + Chr(13) + Chr(10) +  "Autor 5 : " + cDescAut5

				FBUSUSUAR11(cIdentAut5)

				If Select((cAliastmp1)) <> 0

					_cMensAut += Chr(13) + Chr(10) +  "Plano: " + (cAliastmp1)->CodPla + ' - ' +  (cAliastmp1)->DesPla
					_cMensAut += Chr(13) + Chr(10) +  "CCO: " +(cAliastmp1)->CodCCo
					_cMensAut += Chr(13) + Chr(10) +  "Data Inclusão: " + substr((cAliastmp1)->DtInc,7,2)+'/'+substr((cAliastmp1)->DtInc,5,2)+'/'+substr((cAliastmp1)->DtInc,1,4)
					_cMensAut += Chr(13) + Chr(10) +  "Data Exclusão: " + substr((cAliastmp1)->DtBloq,7,2)+'/'+substr((cAliastmp1)->DtBloq,5,2)+'/'+substr((cAliastmp1)->DtBloq,1,4)
				EndIf

			EndIf
		EndIf

		ret:= _cMensAut

	endIf
//ElseIf trim(nTpAutor) == 'RDA'

//Obs: Favor verificar a possibilidade de constar automaticamente neste email o nome do autor, plano.

	if ident == 2
		For x:= 1 to Len(aProcFor)
			If x == 1
				_cMenspro := aProcFor[x] + CRLF
			Else
				_cMenspro += aProcFor[x] + CRLF
			EndIf

		next
		ret:= _cMenspro
	EndIf

Return(ret)

static function fCadMulAns()

	If trim(nTpProc) == "ANS Multa"

		U_caba191(cNCab411,cNproc411,cNCompP411)

	Else

		MsgAlert("Processo Não è Multa Ans - NÃO é possivel Incluir Multa Ans em processo que Não tenha o Tipo do Processo como  ANS Multa  !!! ","Atencao!")

	EndIf

	oDlg1:End()

Return()


static function fVazEmail()

	U_caba414(cNCab411,cNproc411,cNCompP411)

Return()

static Function fValUsu(nTpProc)

	If nTpProc ==  "PROCESSO INTERNO"

		If cUsu410   $ cUsu410F

			a:= 'b'

		Else

			MsgAlert("Usuario Sem Premissao para lançar este tipo de Processo "+nTpProc+"   !!! ","Atencao!")
			oDlg1:End()
		EndIF

	Else

		If cUsu410   $ cUsu410J

			a:= 'b'

		Else

			MsgAlert("Usuario Sem Premissao para lançar este tipo de Processo "+nTpProc+"   !!! ","Atencao!")
			oDlg1:End()
		EndIF

	EndIF

return()


Static Function fCargaTema()

	local cAliastmp      := GetNextAlias()
	Private cQuery       := " "
	cQuery := "select pd8_codigo codigo ,  trim(pd8_tema) tema "
	cQuery += CRLF+ " from  " + RetSqlName("PD8") +" PD8 "
	cQuery += CRLF+ " where PD8_filial = '"+xFilial('PD8')+ "' and PD8.d_E_L_E_T_ = ' ' "

	If Select((cAliastmp)) <> 0
		(cAliastmp)->(DbCloseArea())
	Endif

	TCQuery cQuery New Alias (cAliastmp)

	(cAliastmp)->( DbGoTop() )

	While !Eof()
		If (cAliastmp)->codigo == '01'
			aadd(aTema ,trim((cAliastmp)->tema ))
		elseif (cAliastmp)->codigo == '02'
			aadd(aStatusAns ,trim((cAliastmp)->tema ))
		EndIf

		DbSkip()

	EndDo

Return()


static function fBcoConhec()

	If nOpcm  != 3

		dbgoto(PBW->(RECNO()))

		MsDocument("PBW", PBW->(RECNO()), 4 )

	EndIf

Return()

static function fIDFluig()// Matheus Andrade

	local cCodEmp := FWCodEmp()

	if cCodEmp=="01"
		// chama a tela do Ged Fluig.
		ShellExecute( "open", "https://fluig.caberj.com.br/portal/p/caberj/ecmnavigation?app_ecm_navigation_doc=505", "", "", 1 )
	elseif cCodEmp=="02"
		ShellExecute( "open", "https://fluig.caberj.com.br/portal/p/caberj/ecmnavigation?app_ecm_navigation_doc=506", "", "", 1 )
	EndIf

Return()
