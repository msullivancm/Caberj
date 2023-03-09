#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#include 'shell.ch'

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR290     บAutor  ณAnderson Rangel   บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio Demonstrativo de Anแlise de Conta M้dica          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ E INTEGRAL                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR290()
	
    Local aArea 	:= GetArea()
    Private cOper   := " "
    Private cRdaDe  := " "
    Private cRdaAte := " "
    Private cAno    := " "
    Private cMes    := " "
    Private cPegDe  := " "
    Private cPegAte := " "
    Private nFase   := 0
    Private cClasRda:= " "
    Private cLatDe  := " "
    Private cLatAte := " "
    Private dProDe  := date()
    Private dProAte := date()
    Private cEspDe  := " "
    Private cEspAte := " "
    Private cLdgDe  := " "
    Private cLdgAte := " "
    Private cEmpDe  := " "
    Private cEmpAte := " "
    Private cConDe  := " "
    Private cConAte := " "
    Private cSucoDe := " "
    Private cSucoAte:= " "
    Private cPlanDe := " "
    Private cPlanAte:= " "
    Private cProcDe := " "
    Private cProcAte:= " "
    Private cGuiaDe := " "
    Private cGuiaAte:= " "
    Private dDigtDe := date()
    Private dDigtAte:= date()
    Private cPerg	:= "CABR290"	
	
	//Cria grupo de perguntas
	CABR290A(cPerg)

	
	If Pergunte(cPerg,.T.)
    
        cOper   := MV_PAR01
        cRdaDe  := MV_PAR02
        cRdaAte := MV_PAR03
        cAno    := MV_PAR04
        cMes    := MV_PAR05
        cPegDe  := MV_PAR06
        cPegAte := MV_PAR07
        nFase   := MV_PAR08
        cClasRda:= MV_PAR09
        cLatDe  := MV_PAR10
        cLatAte := MV_PAR11
        dProDe  := MV_PAR12
        dProAte := MV_PAR13
        cEspDe  := MV_PAR14
        cEspAte := MV_PAR15
        cLdgDe  := MV_PAR16
        cLdgAte := MV_PAR17
        cEmpDe  := MV_PAR18
        cEmpAte := MV_PAR19
        cConDe  := MV_PAR20
        cConAte := MV_PAR21
        cSucoDe := MV_PAR22
        cSucoAte:= MV_PAR23
        cPlanDe := MV_PAR24
        cPlanAte:= MV_PAR25
        cProcDe := MV_PAR26
        cProcAte:= MV_PAR27
        cGuiaDe := MV_PAR28
        cGuiaAte:= MV_PAR29
        dDigtDe := MV_PAR30
        dDigtAte:= MV_PAR31
		
        IF cAno = " "      //Ano
            
            MsgAlert("Parโmetro de Ano nใo foi Preenchido","Aten็ใo")        
            Return                                                                           
        
        Else
            
            //----------------------------------------------------
            //Validando se existe o Excel instalado na mแquina
            //para nใo dar erro e o usuแrio poder visualizar em
            //outros programas como o LibreOffice
            //----------------------------------------------------
            //If ApOleClient("MSExcel")
                
                Processa({||CABR290C()},'Gerando Relat๓rio em planilha...')
                
            //Else
                
            //    MsgInfo("Nใo foi Encontrado o Produto MS Excel instalado!","Aten็ใo")
                
            //    if MsgYesNo("Deseja Gerar Relatorio CSV?", "Aten็ใo")
                
            //        Processa({||CABR290D()},'Gerando Relatorio CSV...')
                
            //    Else   

            //        Return
                
            //    EndIf
            
            //EndIf

        EndIf
		
	EndIf
	
	RestArea(aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR290C  บAutor  ณAnderson Rangel     บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR290A(_cPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	
	u_CABASX1(_cPerg,"01","Operadora ?"		    ,"a","a","MV_CH1"	,"C",04	,0,0,"G","","B89PLS","","","MV_PAR01",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"02","RDA De ?"		    ,"a","a","MV_CH2"	,"C",06	,0,0,"G","","BA0PLS","","","MV_PAR02",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"03","RDA Ate ?"		    ,"a","a","MV_CH3"	,"C",06	,0,0,"G","","BA0PLS","","","MV_PAR03",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"04","Ano Base ?"		    ,"a","a","MV_CH4"	,"C",04 ,0,0,"G","",""		,"","","MV_PAR04",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"05","M๊s Base ?"	        ,"a","a","MV_CH5"	,"C",02 ,0,0,"G","",""		,"","","MV_PAR05",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"06","Peg De ?"	        ,"a","a","MV_CH6"	,"C",08 ,0,0,"G","","BC1PLS","","","MV_PAR06",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
    u_CABASX1(_cPerg,"07","Peg Ate ?"		    ,"a","a","MV_CH7"	,"C",08	,0,0,"G","","BC1PLS","","","MV_PAR07",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"08","Fase ?"      		,"a","a","MV_CH8"	,"N",01 ,0,0,"C","",""      ,"","","MV_PAR08","Pronta"  ,"","","","Faturada"    ,"","","Em conferencia" ,"","","Todas"  ,"","","","","",aHelpPor,{},{},"")
	
    Aadd(aHelpPor,{	"Informe a classe do RDA",;
					"Ex.: CLI, HOS etc.",;
					"Utilize ด,ด "})

    u_CABASX1(_cPerg,"09","Classe RDA ?"		,"a","a","MV_CH9"	,"C",30 ,0,0,"G","",""      ,"","","MV_PAR09",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	
    Aadd(aHelpPor,{" "})
    
    u_CABASX1(_cPerg,"10","Local Atend De ?"    ,"a","a","MV_CH10"	,"C",03	,0,0,"G","","BD1PLS","","","MV_PAR10",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"11","Local Atend Ate ?"	,"a","a","MV_CH11"	,"C",03	,0,0,"G","","BD1PLS","","","MV_PAR11",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"12","Data Proced. De ?"	,"a","a","MV_CH12"	,"D",08	,0,0,"G","",""		,"","","MV_PAR12",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
    u_CABASX1(_cPerg,"13","Data Proced. Ate ?"	,"a","a","MV_CH13"	,"D",08	,0,0,"G","",""      ,"","","MV_PAR13",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"14","Especialidade De ?"	,"a","a","MV_CH14"	,"C",03	,0,0,"G","","B2HPLS","","","MV_PAR14",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"15","Especialidade Ate ?"	,"a","a","MV_CH15"	,"C",03	,0,0,"G","","B2HPLS","","","MV_PAR15",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"16","Local Dig. De ?"		,"a","a","MV_CH16"	,"C",04	,0,0,"G","","BAZPLS","","","MV_PAR16",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"17","Local Dig. Ate ?"	,"a","a","MV_CH17"	,"C",04	,0,0,"G","","BAZPLS","","","MV_PAR17",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"18","Empresa De ?"	    ,"a","a","MV_CH18"	,"C",04	,0,0,"G","","B7APLS","","","MV_PAR18",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
    u_CABASX1(_cPerg,"19","Empresa Ate ?"		,"a","a","MV_CH19"	,"C",04	,0,0,"G","","B7APLS","","","MV_PAR19",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"20","Contrato De ?"		,"a","a","MV_CH20"	,"C",12	,0,0,"G","","B7BPLS","","","MV_PAR20",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"21","Contrato Ate ?"		,"a","a","MV_CH21"	,"C",12	,0,0,"G","","B7BPLS","","","MV_PAR21",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"22","Subcontrato De ?"	,"a","a","MV_CH22"	,"C",09	,0,0,"G","","B7CPLS","","","MV_PAR22",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"23","Subcontrato Ate ?"	,"a","a","MV_CH23"	,"C",09	,0,0,"G","","B7CPLS","","","MV_PAR23",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"24","Plano De ?"	        ,"a","a","MV_CH24"	,"C",04	,0,0,"G","","B2DPLS","","","MV_PAR24",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
    u_CABASX1(_cPerg,"25","Plano Ate ?"		    ,"a","a","MV_CH25"	,"C",04	,0,0,"G","","B2DPLS","","","MV_PAR25",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"26","Procedimento De ?"	,"a","a","MV_CH26"	,"C",10	,0,0,"G","","BGHPLS","","","MV_PAR26",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"27","Procedimento Ate ?"	,"a","a","MV_CH27"	,"C",10	,0,0,"G","","BGHPLS","","","MV_PAR27",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"28","Numero Guia De ?"	,"a","a","MV_CH28"	,"C",18	,0,0,"G","",""		,"","","MV_PAR28",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"29","Numero Guia Ate ?"   ,"a","a","MV_CH29"	,"C",18	,0,0,"G","",""		,"","","MV_PAR29",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
	u_CABASX1(_cPerg,"30","Data Digitacao De ?"	,"a","a","MV_CH30"	,"D",08	,0,0,"G","",""		,"","","MV_PAR30",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
    u_CABASX1(_cPerg,"31","Data Digitacao Ate ?","a","a","MV_CH31"	,"D",08	,0,0,"G","",""		,"","","MV_PAR31",""		,"","","",""			,"","",""		        ,"","",""       ,"","","","","",aHelpPor,{},{},"")
    
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR290D  บAutor  ณAnderson Rangel     บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por tratar a query, facilitando assim    บฑฑ
ฑฑบ          ณa manuten็ใo do fonte.                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR290B()
	
    Local xz     := 0
   	Local cQuery := ""                                                                                                  
                                                                                                                
    cQuery += "SELECT BD7_NUMLOT NUM_DEMONST,                                                                                                                                       " + c_ent
    cQuery += "       TO_CHAR(SYSDATE,'DD/MM/YYYY') DATA_EMISSAO,                                                                                                                   " + c_ent
    cQuery += "       BD7_CODRDA CODRDA,                                                                                                                                            " + c_ent
    cQuery += "       FORMATA_CGC(TRIM(BAU_CPFCGC),TRIM(BAU_TIPPE)) CGC,                                                                                                            " + c_ent
    cQuery += "       BAU_NOME NOME_PRESTADOR,                                                                                                                                      " + c_ent
    
    If cEmpAnt == '01'
        cQuery += "       RETORNA_CNES(BD7_CODRDA,'C') CNES,                                                                                                                        " + c_ent
    else
        cQuery += "       RETORNA_CNES(BD7_CODRDA,'I') CNES,                                                                                                                        " + c_ent
    EndIf

    cQuery += "       E2_PREFIXO||E2_NUM||E2_PARCELA NUM_FAT,                                                                                                                       " + c_ent
    cQuery += "       BD7F.BD7_CODLDP||BD7F.BD7_CODPEG LOTE,                                                                                                                        " + c_ent
    cQuery += "       TO_CHAR(TO_DATE(BCI_DATREC,'YYYYMMDD'),'DD/MM/YYYY') DATA_LOTE,                                                                                               " + c_ent
    cQuery += "       NVL(TRIM(BCI_PROTOC),' - ') NUM_PROTOC,                                                                                                                       " + c_ent
    cQuery += "       SIGA.FORMATA_MATRICULA_MS(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO) MATBENF,                                                                " + c_ent
    cQuery += "       BA1_NOMUSR BENEF,                                                                                                                                             " + c_ent
    cQuery += "       BD7_NUMERO GUIASENHA,                                                                                                                                         " + c_ent
    cQuery += "       TO_CHAR(TO_DATE(BD7_DATPRO,'YYYYMMDD'),'DD/MM/YYYY') DATREAL,                                                                                                 " + c_ent
    cQuery += "       BD6F.BD6_QTDPRO QTDEXE,                                                                                                                                       " + c_ent
    cQuery += "       SUBSTR(BD6_DESPRO,1,50) DESCSER,                                                                                                                              " + c_ent
    cQuery += "       PLS_COD_TABELA(BD7_CODPRO) CODTAB,                                                                                                                            " + c_ent
    cQuery += "       BD7_CODPRO CODSER,                                                                                                                                            " + c_ent
    cQuery += "       DECODE(TRIM(BD7_CODUNM),'CIR','00','AUX','01','INS','05','PA','06','HM','12','11') GRAUPART,                                                                  " + c_ent
    cQuery += "       BD7_VLRPAG+BD7_VLRGLO  INFOR,                                                                                                                                 " + c_ent
    cQuery += "       BD7_VLRPAG PROCGUIA,                                                                                                                                          " + c_ent
    cQuery += "       BD7_VLRPAG LIBGUIA,                                                                                                                                           " + c_ent
    cQuery += "       BD7_VLRGLO GLOSAGUIA,                                                                                                                                         " + c_ent
    cQuery += "       PROCPROT,                                                                                                                                                     " + c_ent
    cQuery += "       LIBPROT,                                                                                                                                                      " + c_ent
    cQuery += "       GLOSAPROT,                                                                                                                                                    " + c_ent
    
    If cEmpAnt == "01"
        cQuery += "   CASE WHEN BD7_VLRGLO = '0' THEN '' ELSE SIGA.INFO_GLOSA_TISS_2('CABERJ',BD7_CODLDP,BD7_CODPEG, BD7_NUMERO,BD7_SEQUEN,'COD_GLO') END MOT_GLOSA,                " + c_ent
    else
       cQuery += "    CASE WHEN BD7_VLRGLO = '0' THEN '' ELSE SIGA.INFO_GLOSA_TISS_2('INTEGRAL',BD7_CODLDP,BD7_CODPEG, BD7_NUMERO,BD7_SEQUEN,'COD_GLO') END MOT_GLOSA,              " + c_ent
    EndIf
    
    If cEmpAnt == "01"       
        cQuery += "   CASE WHEN BD7_VLRGLO = '0' THEN '' ELSE SUBSTR(SIGA.INFO_GLOSA_TISS_2('CABERJ',BD7_CODLDP,BD7_CODPEG, BD7_NUMERO,BD7_SEQUEN,'DES_GLO'),1,52) END DESCR_GLOSA  " + c_ent
    else
        cQuery += "   CASE WHEN BD7_VLRGLO = '0' THEN '' ELSE SUBSTR(SIGA.INFO_GLOSA_TISS_2('INTEGRAL',BD7_CODLDP,BD7_CODPEG, BD7_NUMERO,BD7_SEQUEN,'DES_GLO'),1,52) END DESCR_GLOSA" + c_ent
    EndIf
    

    cQuery += "  FROM " + RetSqlName('BD6') + " BD6F, " + RetSqlName('BCI') + " BCI, " + RetSqlName('SE2') + " SE2,                                                                 " + c_ent
    cQuery += "       " + RetSqlName('BD7') + " BD7F, " + RetSqlName('BAU') + " BAU, " + RetSqlName('BA1') + " BA1,                                                                 " + c_ent
    cQuery += "       ( SELECT SUM(BD7_VLRPAG) PROCPROT,                                                                                                                            " + c_ent
    cQuery += "                SUM(BD7_VLRPAG) LIBPROT,                                                                                                                             " + c_ent
    cQuery += "                SUM(BD7_VLRGLO) GLOSAPROT,                                                                                                                           " + c_ent
    cQuery += "                NVL(TRIM(BCI_PROTOC),' - ') PROTOCOLO                                                                                                                " + c_ent
    cQuery += "         FROM " + RetSqlName('BCI') + " BCI, " + RetSqlName('BD7') + " BD7                                                                                           " + c_ent
    cQuery += "         WHERE BD7_FILIAL = ' '                                                                                                                                      " + c_ent
    cQuery += "            AND BCI.BCI_FILIAL = ' '                                                                                                                                 " + c_ent
    
    IF cOper <> " "     //Operadora
        cQuery += "        AND BD7.BD7_CODOPE = '"+cOper+"'                                                                                                                         " + c_ent
    EndIf

    IF nFase == 1        //Pronta
        cQuery += "        AND BD7_FASE = '3'                                                                                                                                       " + c_ent
    elseif nFase == 2    //Faturada
        cQuery += "        AND BD7_FASE = '4'                                                                                                                                       " + c_ent
    elseif nFase == 3    //Em Confer๊ncia
        cQuery += "        AND BD7_FASE = '2'                                                                                                                                       " + c_ent
    else                //Todas
        cQuery += "        AND BD7_FASE IN ('2','3','4')                                                                                                                            " + c_ent
    EndIf
    
    IF cRdaDe <> " "    //RDA
        cQuery += "        AND BD7_CODRDA BETWEEN LPAD('"+cRdaDe+"',6,'0') AND LPAD('"+cRdaAte+"',6,'0')                                                                            " + c_ent
    EndIf    

    IF  cMes <> " "      //Mes
        cQuery += "        AND BD7_NUMLOT LIKE '"+cAno+cMes+"'||'%'                                                                                                                 " + c_ent
    else
        cQuery += "        AND BD7_NUMLOT LIKE '"+cAno+"'||'%'                                                                                                                      " + c_ent
    EndIf

    IF cPegDe <> " "    //Peg
        cQuery += "        AND BD7_CODPEG BETWEEN '"+cPegDe+"' AND '"+cPegAte+"'                                                                                                    " + c_ent
    EndIf

    IF cLatDe <> " "    //Local de Atendimento
        cQuery += "        AND BD7_LOCAL BETWEEN '"+cLatDe+"' AND '"+cLatAte+"'                                                                                                     " + c_ent
    EndIf

    IF dtos(dProDe) <> " "  //Data do Procedimento
        cQuery += "        AND BD7_DATPRO BETWEEN '"+dtos(dProDe)+"' AND '"+dtos(dProAte)+"'                                                                                        " + c_ent
    EndIf

    IF cEspDe <> " "    //C๓digo da Especialidade
        cQuery += "        AND BD7_CODESP BETWEEN '"+cEspDe+"' AND '"+cEspAte+"'                                                                                                    " + c_ent
    EndIf

    IF cLdgDe <> " "    //C๓digo Local de Digita็ใo 
        cQuery += "        AND BD7_CODLDP BETWEEN '"+cLdgDe+"' AND '"+cLdgAte+"'                                                                                                    " + c_ent
    EndIf

    IF cEmpDe <> " "    //C๓digo da Empresa
        cQuery += "        AND BD7_CODEMP BETWEEN '"+cEmpDe+"' AND '"+cEmpAte+"'                                                                                                    " + c_ent
    EndIf

    IF cConDe <> " "    //C๓digo do Contrato
        cQuery += "        AND BD7_CONEMP BETWEEN '"+cConDe+"' AND '"+cConAte+"'                                                                                                    " + c_ent
    EndIf

    IF cSucoDe <> " "    //C๓digo da Subcontrato
        cQuery += "        AND BD7_SUBCON BETWEEN '"+cSucoDe+"' AND '"+cSucoAte+"'                                                                                                  " + c_ent
    EndIf

    IF cPlanDe <> " "    //C๓digo do Plano
        cQuery += "        AND BD7_CODPLA BETWEEN '"+cPlanDe+"' AND '"+cPlanAte+"'                                                                                                  " + c_ent
    EndIf

    IF cProcDe <> " "    //C๓digo do Procedimento
        cQuery += "        AND BD7_CODPRO BETWEEN '"+cProcDe+"' AND '"+cProcAte+"'                                                                                                  " + c_ent
    EndIf

    IF dtos(dDigtDe) <> " "  //Data de Digita็ใo
        cQuery += "        AND BD7_DTDIGI BETWEEN '"+dtos(dDigtDe)+"' AND '"+dtos(dDigtAte)+"'                                                                                      " + c_ent
    EndIf

    cQuery += "            AND BD7_SITUAC = '1'                                                                                                                                     " + c_ent
    cQuery += "            AND BD7_BLOPAG <> '1'                                                                                                                                    " + c_ent
    cQuery += "            AND BD7_CODOPE = BCI.BCI_CODOPE                                                                                                                          " + c_ent
    cQuery += "            AND BD7_CODLDP = BCI.BCI_CODLDP                                                                                                                          " + c_ent
    cQuery += "            AND BD7_CODPEG = BCI.BCI_CODPEG                                                                                                                          " + c_ent
    cQuery += "            AND BD7_CODRDA = BCI.BCI_CODRDA                                                                                                                          " + c_ent
    cQuery += "            AND BCI.D_E_L_E_T_ = ' '                                                                                                                                 " + c_ent
    cQuery += "            AND BD7.D_E_L_E_T_ = ' '                                                                                                                                 " + c_ent
    cQuery += "            GROUP BY NVL(TRIM(BCI_PROTOC),' - ') ) TOTPROT                                                                                                           " + c_ent
    cQuery += " WHERE BD7F.BD7_FILIAL = ' '                                                                                                                                         " + c_ent
    cQuery += "   AND BD6F.BD6_FILIAL = ' '                                                                                                                                         " + c_ent
    cQuery += "   AND E2_FILIAL = '01'                                                                                                                                              " + c_ent
    cQuery += "   AND BCI.BCI_FILIAL = ' '                                                                                                                                          " + c_ent
    cQuery += "   AND BAU.BAU_FILIAL = ' '                                                                                                                                          " + c_ent
    cQuery += "   AND BA1_FILIAL = ' '                                                                                                                                              " + c_ent
    
    //Classe RDA
    cClasRdaTrat := ""
    aClasRda := StrTokArr(alltrim(cClasRda), "," )
    For xz := 1 To Len(aClasRda)
		cClasRdaTrat += IIF(xz == Len(aClasRda), "'"+aClasRda[xz]+"'" , "'"+aClasRda[xz]+"',")
	Next 
	cClasRda := cClasRdaTrat
	If !empty(cClasRda)
        cQuery += "   AND BAU_TIPPRE      IN (  "+ cClasRda +"   )	                                                                                                                " + c_ent
    EndIf

    IF cOper <> " "     //Operadora
        cQuery += "        AND BD7F.BD7_CODOPE = '"+cOper+"'                                                                                                                         " + c_ent
    EndIf

    IF nFase == 1        //Pronta
        cQuery += "        AND BD7F.BD7_FASE = '3'                                                                                                                                       " + c_ent
    elseif nFase == 2    //Faturada
        cQuery += "        AND BD7F.BD7_FASE = '4'                                                                                                                                       " + c_ent
    elseif nFase == 3    //Em Confer๊ncia
        cQuery += "        AND BD7F.BD7_FASE = '2'                                                                                                                                       " + c_ent
    else                //Todas
        cQuery += "        AND BD7F.BD7_FASE IN ('2','3','4')                                                                                                                            " + c_ent
    EndIf
    
    IF cRdaDe <> " "    //RDA
        cQuery += "        AND BD7F.BD7_CODRDA BETWEEN LPAD('"+cRdaDe+"',6,'0') AND LPAD('"+cRdaAte+"',6,'0')                                                                            " + c_ent
    EndIf    

    IF  cMes <> " "      //Mes
        cQuery += "        AND BD7F.BD7_NUMLOT LIKE '"+cAno+cMes+"'||'%'                                                                                                                 " + c_ent
    else
        cQuery += "        AND BD7F.BD7_NUMLOT LIKE '"+cAno+"'||'%'                                                                                                                      " + c_ent
    EndIf

    IF cPegDe <> " "    //Peg
        cQuery += "        AND BD7F.BD7_CODPEG BETWEEN '"+cPegDe+"' AND '"+cPegAte+"'                                                                                                    " + c_ent
    EndIf

    IF cLatDe <> " "    //Local de Atendimento
        cQuery += "        AND BD7F.BD7_LOCAL BETWEEN '"+cLatDe+"' AND '"+cLatAte+"'                                                                                                     " + c_ent
    EndIf

    IF dtos(dProDe) <> " "  //Data do Procedimento
        cQuery += "        AND BD7F.BD7_DATPRO BETWEEN '"+dtos(dProDe)+"' AND '"+dtos(dProAte)+"'                                                                                        " + c_ent
    EndIf

    IF cEspDe <> " "    //C๓digo da Especialidade
        cQuery += "        AND BD7F.BD7_CODESP BETWEEN '"+cEspDe+"' AND '"+cEspAte+"'                                                                                                    " + c_ent
    EndIf

    IF cLdgDe <> " "    //C๓digo Local de Digita็ใo 
        cQuery += "        AND BD7F.BD7_CODLDP BETWEEN '"+cLdgDe+"' AND '"+cLdgAte+"'                                                                                                    " + c_ent
    EndIf

    IF cEmpDe <> " "    //C๓digo da Empresa
        cQuery += "        AND BD7F.BD7_CODEMP BETWEEN '"+cEmpDe+"' AND '"+cEmpAte+"'                                                                                                    " + c_ent
    EndIf

    IF cConDe <> " "    //C๓digo do Contrato
        cQuery += "        AND BD7F.BD7_CONEMP BETWEEN '"+cConDe+"' AND '"+cConAte+"'                                                                                                    " + c_ent
    EndIf

    IF cSucoDe <> " "    //C๓digo da Subcontrato
        cQuery += "        AND BD7F.BD7_SUBCON BETWEEN '"+cSucoDe+"' AND '"+cSucoAte+"'                                                                                                  " + c_ent
    EndIf

    IF cPlanDe <> " "    //C๓digo do Plano
        cQuery += "        AND BD7F.BD7_CODPLA BETWEEN '"+cPlanDe+"' AND '"+cPlanAte+"'                                                                                                  " + c_ent
    EndIf

    IF cProcDe <> " "    //C๓digo do Procedimento
        cQuery += "        AND BD7F.BD7_CODPRO BETWEEN '"+cProcDe+"' AND '"+cProcAte+"'                                                                                                  " + c_ent
    EndIf

    IF cGuiaDe <> " "    //C๓digo da Guia
        cQuery += "        AND BD6_CODOPE||BD6_ANOINT||BD6_MESINT||BD6_NUMINT BETWEEN '"+cGuiaDe+"' AND '"+cGuiaAte+"'                                                              " + c_ent
    EndIf

    IF dtos(dDigtDe) <> " "  //Data de Digita็ใo
        cQuery += "        AND BD7F.BD7_DTDIGI BETWEEN '"+dtos(dDigtDe)+"' AND '"+dtos(dDigtAte)+"'                                                                                      " + c_ent
    EndIf

    cQuery += "   AND BD7F.BD7_SITUAC = '1'                                                                                                                                         " + c_ent
    cQuery += "   AND BD7F.BD7_BLOPAG <> '1'                                                                                                                                        " + c_ent
    cQuery += "   AND E2_TIPO IN ('FT','DP')                                                                                                                                        " + c_ent
    cQuery += "   AND BAU.BAU_CODIGO =  BD7_CODRDA                                                                                                                                  " + c_ent
    cQuery += "   AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL                                                                                                                             " + c_ent
    cQuery += "   AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE                                                                                                                             " + c_ent
    cQuery += "   AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP                                                                                                                             " + c_ent
    cQuery += "   AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG                                                                                                                             " + c_ent
    cQuery += "   AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO                                                                                                                             " + c_ent
    cQuery += "   AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV                                                                                                                             " + c_ent
    cQuery += "   AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN                                                                                                                             " + c_ent
    cQuery += "   AND NVL(TRIM(BCI_PROTOC),' - ') = PROTOCOLO                                                                                                                       " + c_ent
    cQuery += "   AND BD6F.BD6_CODOPE = BCI.BCI_CODOPE                                                                                                                              " + c_ent
    cQuery += "   AND BD6F.BD6_CODLDP = BCI.BCI_CODLDP                                                                                                                              " + c_ent
    cQuery += "   AND BD6F.BD6_CODPEG = BCI.BCI_CODPEG                                                                                                                              " + c_ent
    cQuery += "   AND BD6F.BD6_CODRDA = BCI.BCI_CODRDA                                                                                                                              " + c_ent
    cQuery += "   AND E2_PLOPELT = BD7F.BD7_OPELOT                                                                                                                                  " + c_ent
    cQuery += "   AND E2_PLLOTE =  BD7F.BD7_NUMLOT                                                                                                                                  " + c_ent
    cQuery += "   AND E2_CODRDA = BD7F.BD7_CODRDA                                                                                                                                   " + c_ent
    cQuery += "   AND BD7_CODOPE = BA1_CODINT                                                                                                                                       " + c_ent
    cQuery += "   AND BD7_CODEMP = BA1_CODEMP                                                                                                                                       " + c_ent
    cQuery += "   AND BD7_MATRIC = BA1_MATRIC                                                                                                                                       " + c_ent
    cQuery += "   AND BD7_TIPREG = BA1_TIPREG                                                                                                                                       " + c_ent
    cQuery += "   AND BD6F.D_E_L_E_T_ = ' '                                                                                                                                         " + c_ent
    cQuery += "   AND BCI.D_E_L_E_T_ = ' '                                                                                                                                          " + c_ent
    cQuery += "   AND SE2.D_E_L_E_T_ = ' '                                                                                                                                          " + c_ent
    cQuery += "   AND BD7F.D_E_L_E_T_ = ' '                                                                                                                                         " + c_ent
    cQuery += "   AND BAU.D_E_L_E_T_ = ' '                                                                                                                                          " + c_ent
    cQuery += "   AND BA1.D_E_L_E_T_ = ' '                                                                                                                                          " + c_ent
    cQuery += "ORDER BY BD7F.BD7_CODLDP||BD7F.BD7_CODPEG, BD7_NUMERO, E2_PREFIXO||E2_NUM||E2_PARCELA,                                                                               " + c_ent
    cQuery += "         TO_CHAR(TO_DATE(BCI_DATREC,'YYYYMMDD'),'DD/MM/YYYY'), NVL(TRIM(BCI_PROTOC),' - '),                                                                          " + c_ent
    cQuery += "         BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO, BD6_DATPRO                                                                                      " + c_ent
        
    memowrite("C:\temp\CABR290.sql",cQuery)
	
Return cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR290C  บAutor  ณAnderson Rangel     บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por gerar o relat๓rio em CSV, pois       บฑฑ
ฑฑบ          ณalguns usuแrios nใo possuem o Excel.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR290C()
    Local nI        := 0
    Local aDados    := {}
    Local aCabec	:= {}

    //---------------------------------------------
	//CABR290B Realiza toda a montagem da query
	//facilitando a manuten็ใo do fonte
	//---------------------------------------------
    _cQuery := CABR290B()

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"R290",.T.,.T.)         

    For nI := 1 to 5
        IncProc('Processando...')
    Next

    If !R290->(Eof())
            
        aCabec := {"NUM_DEMONST","DATA_EMISSAO","CODRDA","CGC","NOME_PRESTADOR","CNES","NUM_FAT","LOTE","DATA_LOTE","NUM_PROTOC",;
                "MATBENF","BENEF","GUIASENHA","DATREAL","QTDEXE","DESCSER","CODTAB","CODSER","GRAUPART","INFOR","PROCGUIA",;
                "LIBGUIA","GLOSAGUIA","PROCPROT","LIBPROT","GLOSAPROT","MOT_GLOSA","DESCR_GLOSA"} 
        R290->(DbGoTop())
        While !R290->(Eof()) 
            IncProc()		
            aaDD(aDados,{R290->NUM_DEMONST, R290->DATA_EMISSAO, R290->CODRDA, R290->CGC, R290->NOME_PRESTADOR, R290->CNES, R290->NUM_FAT, R290->LOTE, R290->DATA_LOTE, R290->NUM_PROTOC,;
                        R290->MATBENF, R290->BENEF, R290->GUIASENHA, R290->DATREAL, R290->QTDEXE, R290->DESCSER, R290->CODTAB, R290->CODSER, R290->GRAUPART, R290->INFOR, R290->PROCGUIA,;
                        R290->LIBGUIA, R290->GLOSAGUIA, R290->PROCPROT, R290->LIBPROT, R290->GLOSAPROT, R290->MOT_GLOSA, R290->DESCR_GLOSA})  
            R290->(DbSkip())
        End
            
        //Abre excel 
        iF LEN(aDados)>0
            U_DlgToCSV({{"ARRAY"," " ,aCabec,aDados}})
        Endif                        
        //MsgInfo("Planilha Gerada.","Aten็ใo")
    else
        MsgInfo("Nใo hแ dados para os parโmetros informados.","Aten็ใo")    
    EndIf	

    If Select("R290") > 0
        dbSelectArea("R290")
        dbCloseArea()
    EndIf      
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR290D  บAutor  ณAnderson Rangel     บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por gerar o relat๓rio em CSV, pois       บฑฑ
ฑฑบ          ณalguns usuแrios nใo possuem o Excel.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR290D()
	
	Local _aArea 	:= GetArea()
	Local __cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\EXTRATO_RDA"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR290D Realiza toda a montagem da query
	//facilitando a manuten็ใo do fonte
	//---------------------------------------------
	__cQuery := CABR290B()
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,__cQuery),_cAlias2,.T.,.T.)
	
	While !(_cAlias2)->(EOF())
		
		IncProc()
		
		//------------------------------------------------------------------
		//Se for a primeira vez, deve ser criado o arquivo e o cabe็alho
		//------------------------------------------------------------------
		If nHandle = 0
			
			//------------------------------------------------------------------
			// criar arquivo texto vazio a partir do root path no servidor
			//------------------------------------------------------------------
			nHandle := FCREATE(cNomeArq)
			
			If nHandle > 0
				
				cMontaTxt := "NUM_DEMONST ; "
				cMontaTxt += "DATA_EMISSAO ; "
				cMontaTxt += "CODRDA ; "
				cMontaTxt += "CGC ; "
				cMontaTxt += "NOME_PRESTADOR ; "
				cMontaTxt += "CNES ; "
				cMontaTxt += "NUM_FAT ; "
				cMontaTxt += "LOTE ; "
				cMontaTxt += "DATA_LOTE ; "
				cMontaTxt += "NUM_PROTOC ; "
				cMontaTxt += "MATBENF ; "
                cMontaTxt += "BENEF ; "
                cMontaTxt += "GUIASENHA ; "
                cMontaTxt += "DATREAL ; "
                cMontaTxt += "QTDEXE ; "
                cMontaTxt += "DESCSER ; "
                cMontaTxt += "CODTAB ; "
                cMontaTxt += "CODSER ; "
                cMontaTxt += "GRAUPART ; "
                cMontaTxt += "INFOR ; "
                cMontaTxt += "PROCGUIA ; "
                cMontaTxt += "LIBGUIA ; "
                cMontaTxt += "GLOSAGUIA ; "
                cMontaTxt += "PROCPROT ; "
                cMontaTxt += "LIBPROT ; "
                cMontaTxt += "GLOSAPROT ; "
                cMontaTxt += "MOT_GLOSA ; "
                cMontaTxt += "DESCR_GLOSA ; "
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Aten็ใo","Nใo foi possํvel criar o relat๓rio",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := "'" + AllTrim((_cAlias2)->NUM_DEMONST		    ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->DATA_EMISSAO   ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CODRDA		        ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CGC	                ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->NOME_PRESTADOR	    ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CNES	                ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->NUM_FAT	            ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->LOTE	                ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->DATA_LOTE		    ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->NUM_PROTOC	        ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->MATBENF			    ) + ";"
        cMontaTxt := "'" + AllTrim((_cAlias2)->BENEF		        ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->GUIASENHA		    ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->DATREAL              ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->QTDEXE	            ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->DESCSER	            ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CODTAB	            ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CODSER	            ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->GRAUPART     	    ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->INFOR		        ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->PROCGUIA	            ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->LIBGUIA			    ) + ";"
        cMontaTxt += "'" + AllTrim((_cAlias2)->GLOSAGUIA	        ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->PROCPROT		        ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->LIBPROT	            ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->GLOSAPROT			) + ";"
        cMontaTxt += "'" + AllTrim((_cAlias2)->MOT_GLOSA	        ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->DESCR_GLOSA		    ) + ";"
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
		(_cAlias2)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		
		MsgAlert("Relatorio salvo em: "+ cNomeArq)
		
	EndIf
	
	RestArea(_aArea)
	
Return
