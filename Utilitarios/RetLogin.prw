#include "PROTHEUS.CH"
#include "UTILIDADES.CH"

//������������������������������������������������Ŀ
//�Chama a funcao RetLogin contida no UTILIDADES.CH�
//�Funcao chamada na consulta especifica LOGIN     �
//��������������������������������������������������

User Function RetLogin(lMarcaUni)
                         
Default lMarcaUni := .F.

Return RetLogin(lMarcaUni)  

********************************************************************************

//���������������������������������
//�Funcao do INCLUDE UTILIDADES.CH�
//���������������������������������

User Function InfoUsr(cLogins, cSep)

Return InfoUsr(cLogins, cSep)