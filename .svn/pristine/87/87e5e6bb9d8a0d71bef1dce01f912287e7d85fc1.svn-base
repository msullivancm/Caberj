#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"                            
**'-----------------------------------------------------------------------'**                                                                            
**'--Rotina para geração de SE2-------------------------------------------'**                                                                            
**'-----------------------------------------------------------------------'**
User Function GeraPa( )
Local l_Ret  := .f.   
Local xFornece  := " "
Local a_DadosSE2:= {}
Local _cErro  := ""

//default d_DataEmis  := ""
private  a_Banco  := &(GetMv("MV_XBCOPA"))
         
 //////
cQuery := " SELECT *  " // -- E2_NUM ,  E2_PARCELA, E2_FORNECE , E2_LOJA  ,  e2_inss    "                                              
cQuery += "   FROM SE2020   WHERE R_e_c_n_o_ IN   " //(35930,35932,35924)   "                                       
cQuery += "  (35861,35839,37230,37373,37376,37368,37369,37378,37491,37495,37498,37499,37502,37503,37504,37505,37507,37508,37510,37511 "   
cQuery += "  ,37512,37513,37514,37515,37520,37521,37523,37524,37526,37527,37528,37529,37530,37533,37536,37537,37538,37539,37542,37543   " 
cQuery += "  ,37547,37548,37549,37551,37553,37554,37555,37556,37557,37562,37563,37564,37566,37567,37568,37569,37570,37571,37572,37574   " 
cQuery += "  ,37578,37579,37580,37581,37583,37585,37586,37587,37588,37590,37591,37593,37594,37595,37596,37597,37598,37599,37601,37603   " 
cQuery += "  ,37604,37606,37607,37609,37611,37613,37614,37615,37616,37379,37382,37383,37386,37387,37390,37394,37398,37401,37403,37404   " 
cQuery += "  ,37407,37408,37409,37410,37412,37415,37416,37423,37424,37425,37426,37427,37428,37430,37431,37432,37433,37436,37437,37438   " 
cQuery += "  ,37442,37444,37447,37448,37449,37451,37452,37453,37454,37457,37459,37461,37463,37466,37467,37468,37469,37471,37472,37473   " 
cQuery += "  ,37474,37478,37479,37480,37481,37485,37486,37489,37621,37417,37622,37620,37624,37626,37477,37627,37628,37629,37630,37633   " 
cQuery += "  ,37634,37635,37631,37636,37637,37638,37639,37623,38516)    " 
//////
If Select("YTMP") > 0
	dbSelectArea("YTMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "YTMP" New
dbSelectArea("YTMP")
Ytmp->(dbGoTop())

While Ytmp->(!EOF())   
if Ytmp->e2_inss > 0.00
////////////  
     dbselectArea("SE2")
     dbSetOrder(1)
If !( dbSeek(xFilial("SE2") + YTMP->E2_PREFIXO   + alltrim( YTMP->E2_NUM )+Ytmp->E2_PARCELA+'PA ') )
                                                                     
 aadd(a_DadosSE2, {'E2_PREFIXO'      , YTMP->E2_PREFIXO    , NIL})
 aadd(a_DadosSE2, {'E2_NUM'            , YTmp->e2_NUM            , NIL})
 aadd(a_DadosSE2, {'E2_PARCELA'    , Ytmp->E2_PARCELA    , NIL})
 aadd(a_DadosSE2, {'E2_TIPO'            , 'PA '                           , NIL})
 aadd(a_DadosSE2, {'E2_FORNECE'   , Ytmp->E2_FORNECE   , NIL})
 aadd(a_DadosSE2, {'AUTBANCO'       , a_Banco[1]  , NIL})
 aadd(a_DadosSE2, {'AUTAGENCIA' , a_Banco[2]   , NIL})
 aadd(a_DadosSE2, {'AUTCONTA' , a_Banco[3]   , NIL})
 aadd(a_DadosSE2, {'E2_LOJA'    , Ytmp->E2_LOJA   , NIL})
 aadd(a_DadosSE2, {'E2_NATUREZ' , '12602'  , NIL})
 aadd(a_DadosSE2, {'E2_EMISSAO' , stod('20110826') , NIL})
 aadd(a_DadosSE2, {'E2_VENCTO'  , stod('20110826' )   , NIL})
 aadd(a_DadosSE2, {'E2_VENCREA' , stod('20110826')   , NIL})
 aadd(a_DadosSE2, {'E2_HIST'    , 'Acerto inss Comp 07/2011' , NIL})
 aadd(a_DadosSE2, {'E2_VALOR'   , Ytmp->e2_inss , NIL})
 aadd(a_DadosSE2, {'E2_VLCRUZ'   , Ytmp->e2_inss , NIL})
 aadd(a_DadosSE2, {'E2_CCD'   , '99999'  , NIL})
 aadd(a_DadosSE2, {'E2_YMECPPA'  , '09'   , NIL})    
 aadd(a_DadosSE2, {'E2_YANCPPA'  , '11'  ,NIL})
 
 BEGIN Transaction
    //conout(iIf(PA0->PA0_TPTITU=="6","ADIANTAMENTO A CONVENIADO","ADIANTAMENTO A CREDENCIADO"))
 _lRet  := .T.
 lMsErroAuto := .F.
 MSExecAuto({|x,y,z| Fina050(x,y,z)},a_DadosSE2,,3)
 
// dDataBase := d_DataAnt
 
 IF lMsErroAuto
  conout( "E R R O    N O    E X E C A U T O" )

  lMsHelpAuto := .T.
  DisarmTransaction()
  _cErro := MostraErro(NIL, "C:\erro_exec.GER") // Para gravar o erro
  memowrite("C:\erro_exec.GER", _cErro)

  conout( _cErro )

  _lRet := .F.
 
 ENDIF
 
 
 END Transaction
 
 DbCommitAll()

EndIf      
endif      
  a_DadosSE2 := {}
 YTMP->(DbSkip())
enddo

Return _cErro