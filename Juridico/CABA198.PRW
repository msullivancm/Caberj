#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO2     º Autor ³ AP6 IDE            º Data ³  22/09/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo Para criar tabelas customizadas                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function caba198()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     

LOCAL A:= 'B'  

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "PEB"

dbSelectArea("PEB")                                                                                

dbSetOrder(1)

//SET FILTER TO  PEB_VENC >'20210831' 

AxCadastro(cString,"Tabela Criada PEB - valores presentes dos titulos de multas",cVldExc,cVldAlt)

Return()
/*
SELECT bsq.* , bm1.* , bm1_codint , bm1_codemp ,   bsq_usuari , 
 'UPDATE bm1010 bm1 SET bm1_matric = ''' ||substr(bsq_usuari,9,6)||''',
                bm1_tipreg  = '''||substr(bsq_usuari,15,2)||''', 
                bm1_digito = '''||substr(bsq_usuari,17,1)||''' ,
                bm1_nomusr = '''||ba1_nomusr||'''
                WHERE bm1.r_E_C_N_O_  = '||bm1.R_E_C_N_O_ 

   FROM BSQ010 bsq , bm1010 bm1 , ba1010 ba1 
  WHERE BSQ_FILIAL = ' ' AND bsq.D_e_l_e_t_ = ' ' 
    and Bm1_FILIAL = ' ' AND bm1.D_e_l_e_t_ = ' ' 
    and Ba1_FILIAL = ' ' AND ba1.D_e_l_e_t_ = ' ' 
 AND BSQ_CODEMP = '0013'
 AND BSQ_ANO    = '2020' 
 AND BSQ_MES    = '10'
 AND BSQ_CODLAN IN ('900','901')
 and bm1_origem = bsq_codseq
  and bm1_codemp = '0013'
  and bm1_ano = '2020' 
  and bm1_mes = '10'
  and ba1_codint || ba1_codemp || ba1_matric || ba1_tipreg || ba1.BA1_DIGITO =
     bsq_usuari
  and bm1_codtip in ('970' , '969')
  --and bm1_matric =  ' ' and bm1_tipreg = ' ' and bm1_digito = ' ' 
*/