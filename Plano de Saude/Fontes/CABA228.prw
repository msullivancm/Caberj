/*/{Protheus.doc} User Function CABA228
    Rotina pde axcadastro para que o pessoal do juridico possam cadastrar as nips e eventos encaminhados pela ANS
    @type  Function
    @author Angelo Henrique
    @since 20/06/2022
    @version 1.0    
    /*/
User Function CABA228()

	Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
	Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

	Private cString := "PEP"

	dbSelectArea(cString)
	dbSetOrder(1)

	AxCadastro(cString,"Cadastro de Demandas Escritorio",cVldExc,cVldAlt)

Return 
