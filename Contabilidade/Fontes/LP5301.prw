#INCLUDE "rwmake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �LP5301     � Autor � AP6 IDE            � Data �  07/07/05  ���
�������������������������������������������������������������������������͹��
���Descricao � LESCAUT                                                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/     
/* Em 15.03.06 conforme email da contabilidade trocar a conta no caso
   de NATUREZ="46201" e TIPO=="FER" (ferias) 
   A conta anterior era "22813909" 
   Em 29.04.06 conforme conversa com a Adriana corrigir a conta no caso
   de NATUREZ="46201" e TIPO=="FER" (ferias) 
   A conta anterior era "22813904"   
*/
// De / Para das Conta Cont�beis 19/09/07

User Function LP5301


PRIVATE cconta:=""

IF ALLTRIM(SE2->E2_NATUREZ)=="PIS"
	cconta:="216219016"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="COFINS"
	cconta:="216219015"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="CSLL"
	cconta:="216219014"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)="IRF" .AND. SE2->E2_PREFIXO=="GPE"
	cconta:="216219011"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)="IRF" .AND. SE2->E2_PREFIXO<>"GPE"
	cconta:="216219012" 
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="INSS" .AND. SE2->E2_PREFIXO=="GPE"
    cconta:="216119034"	
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="INSS"
    cconta:="216219017"	
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46201" .AND. SE2->E2_PREFIXO=="GPE"
	cconta:="21811901101"	
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46101" .AND. SE2->E2_TIPO=="RES"
	cconta:="21811901101"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46106" .AND. SE2->E2_TIPO=="FER"
	cconta:="12741901102"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46102"
	cconta:="21811901501"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46108" .AND. SE2->E2_PREFIXO=="GPE"
	cconta:="21811901102"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46101" .AND. SE2->E2_TIPO=="PEN"
	cconta:="218889088"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46116"
	cconta:="216219017"	
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="461161"
	cconta:="21811901502"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46117"
	cconta:="216119034"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="461171"
	cconta:="21811901503"	
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46119"
	cconta:="21611903602"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46101"
	cconta:="21811901101"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="46303"
	cconta:="218219011"
ELSE
	cconta:=SA2->A2_CONTA
ENDIF
Return cconta
