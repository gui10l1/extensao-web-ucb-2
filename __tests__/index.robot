*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${confirmPassword}
${email}
${password}
${editRegister}    17
${browser}    edge

*** Keywords ***
Dado que o Usuario Esta Dentro da Tela de Cadastro
    Open Browser    http://localhost:8080/sign-up    ${browser}
    Maximize Browser Window

E Insere os Dados de Cadastro
    Input Text    id:name    Guilherme Soares
    Input Text    id:email    ${email}
    Input Text    id:phone    61986564388
    Input Text    id:password    123456
    Input Text    id:confirmPassword    ${confirmPassword}
    

E Confirma o Envio do Formulario
    Submit Form    id:form

Entao Deve Aparecer uma Mensagem de Erro
    Element Should Be Visible    id:validator

Entao Aparece uma Mensagem de Erro do Servidor
    Element Should Be Visible    id:error

Dado que o Usuario Esta Dentro da Tela de Login
    Open Browser    http://localhost:8080/login    ${browser}
    Maximize Browser Window

E Insere os Dados de Login
    Input Text    id:email    ${email}
    Input Text    id:password    ${password}

Entao Aparece uma Mensagem Informando o Login Invalido
    Element Should Be Visible    id:error

Entao Redireciona o Usuario para a Dashboard
    Title Should Be    Projeto Web Extensão - Dashboard

Dado que o Usuario Esta Logado na Plataforma
    Open Browser    http://localhost:8080/login    ${browser}
    Maximize Browser Window
    Input Text    id:email    ${email}
    Input Text    id:password    ${password}
    Submit Form    id:form

E Aperta Botao Para Inserir Novo Produto
    Click Button    id:formToggler

E Insere os Dados do Novo Produto
    Input Text    id:name    Novo Produto
    Input Text    id:price    399
    Input Text    id:description    Uma descrição do produto de testes
    Input Text    id:quantity    10

Entao Aparece um Novo Produto Na Tabela
    Table Row Should Contain    id:products-table    1    Novo Produto

E Aperta o Botao Para Editar um Registro
    Submit Form    id:form-${editRegister}

E Insere os Dados Atualizados
    Input Text    id:name    Produto Atualizado
    Input Text    id:price    199
    Input Text    id:description    Um produto novo e atualizado
    Input Text    id:quantity    5

Entao Os Novos Dados Devem Aparecer na Tabela
    Table Row Should Contain    id:products-table    1    Produto Atualizado

E Aperta Botao Para Deletar um Registro
    Submit Form    id:delete-form-${editRegister}

E Confirma a Ação de Deletar
    Handle Alert    ACCEPT

Tabela Deve Estar Vazia
    [Arguments]    ${locator}
    ${row_count}=    Get Element Count    ${locator}//tr
    Should Be Equal As Numbers    ${row_count}    1

Entao o Registro Nao Deve Mais Aparecer na Tabela
    Tabela Deve Estar Vazia    xpath://*[@id='products-table']

E Navega Ate o Perfil
    Click Link    link:Ver perfil

E Insere os Novos Dados do Perfil
    Input Text    id:name    Peril Atualizado
    Input Text    id:email    email@atualizado.com
    Input Text    id:phone    018409810
    Input Text    id:password    1234
    Input Text    id:confirmPassword    ${confirmPassword}

E Insere os Novos Dados do Perfil De Maneira Errada
    Input Text    id:name    Perfil Atualizado
    Input Text    id:email    usuario@existente.com
    Input Text    id:phone    018409810
    Input Text    id:password    1234
    Input Text    id:confirmPassword    ${confirmPassword}

Entao Deve Mostrar os um Alerta Dizendo que os Dados Foram Atualizados
    Element Should Be Visible    id:success
    Element Should Contain    id:success    Informações atualizadas com sucesso!

Entao Deve Mostrar uma Mensagem De Erro Do Servidor
    Element Should Be Visible    id:error
    Element Should Contain    id:error    Erro interno do servidor

Entao Deve Aparecer uma Mensagem de Senha Errada
    Alert Should Be Present

Dado Que Existe outro Usuario Cadastrado na Plataforma
    Dado que o Usuario Esta Dentro da Tela de Cadastro
    Set Global Variable    ${email}    usuario@existente.com
    E Insere os Dados de Cadastro
    E Confirma o Envio do Formulario

*** Test Cases ***
Usuario Faz Cadastro Na Plataforma E Confirma a Senha de Forma Errada
    Dado que o Usuario Esta Dentro da Tela de Cadastro
    Set Global Variable    ${confirmPassword}    1234567
    Set Global Variable    ${email}    gui@gui.com
    E Insere os Dados de Cadastro
    E Confirma o Envio do Formulario
    Entao Deve Aparecer uma Mensagem de Erro

Usuario Faz Cadastro Na Plataforma
    Dado que o Usuario Esta Dentro da Tela de Cadastro
    Set Global Variable    ${confirmPassword}    123456
    Set Global Variable    ${email}    gui@gui.com
    E Insere os Dados de Cadastro
    E Confirma o Envio do Formulario

Usuario Tenta Fazer Cadastro e a Plataforma da um Erro
    Dado que o Usuario Esta Dentro da Tela de Cadastro
    Set Global Variable    ${email}    gui@gui.com
    E Insere os Dados de Cadastro
    E Confirma o Envio do Formulario
    Entao Aparece uma Mensagem de Erro do Servidor

Usuario Tenta Fazer Login na Plataforma Com Usuario ou Senha Invalidos
    Dado que o Usuario Esta Dentro da Tela de Login
    Set Global Variable    ${email}    email@invalido.com
    Set Global Variable    ${password}    senha-incorreta
    E Insere os Dados de Login
    E Confirma o Envio do Formulario
    Entao Aparece uma Mensagem Informando o Login Invalido

Usuario Faz Login na Plataforma
    Dado que o Usuario Esta Dentro da Tela de Login
    Set Global Variable    ${email}    gui@gui.com
    Set Global Variable    ${password}    123456
    E Insere os Dados de Login
    E Confirma o Envio do Formulario
    Entao Redireciona o Usuario para a Dashboard

Usuario Cria um Novo Produto na Plataforma
    Set Global Variable    ${email}    gui@gui.com
    Set Global Variable    ${password}    123456
    Dado que o Usuario Esta Logado na Plataforma
    Sleep    2
    E Aperta Botao Para Inserir Novo Produto
    E Insere os Dados do Novo Produto
    E Confirma o Envio do Formulario
    Entao Aparece um Novo Produto Na Tabela

Usuario Edita um Produto Existente
    Set Global Variable    ${email}    gui@gui.com
    Set Global Variable    ${password}    123456
    Dado que o Usuario Esta Logado na Plataforma
    Sleep    1
    E Aperta o Botao Para Editar um Registro
    Sleep    1
    E Insere os Dados Atualizados
    E Confirma o Envio do Formulario
    Entao Os Novos Dados Devem Aparecer na Tabela

Usuario Deleta um Produto Existente
    Set Global Variable    ${email}    gui@gui.com
    Set Global Variable    ${password}    123456
    Dado que o Usuario Esta Logado na Plataforma
    Sleep    1
    E Aperta Botao Para Deletar um Registro
    E Confirma a Ação de Deletar
    Sleep    1
    Entao o Registro Nao Deve Mais Aparecer na Tabela

Usuario Faz Atualização de Seus Proprios Dados Com Email Duplicado
    Dado Que Existe outro Usuario Cadastrado na Plataforma
    Set Global Variable    ${email}    gui@gui.com
    Set Global Variable    ${password}    123456
    Dado que o Usuario Esta Logado na Plataforma
    Sleep    1
    E Navega Ate o Perfil
    Sleep    1
    Set Global Variable    ${confirmPassword}    1234
    E Insere os Novos Dados do Perfil De Maneira Errada
    E Confirma o Envio do Formulario
    Entao Deve Mostrar uma Mensagem De Erro Do Servidor

Usuario Faz Atualização de Seus Proprios Dados Com Senha Errada
    Set Global Variable    ${email}    gui@gui.com
    Set Global Variable    ${password}    123456
    Dado que o Usuario Esta Logado na Plataforma
    Sleep    1
    E Navega Ate o Perfil
    Sleep    1
    Set Global Variable    ${confirmPassword}    senha-errada
    E Insere os Novos Dados do Perfil
    E Confirma o Envio do Formulario
    Entao Deve Aparecer uma Mensagem de Senha Errada

Usuario Faz Atualização de Seus Proprios Dados
    Set Global Variable    ${email}    gui@gui.com
    Set Global Variable    ${password}    123456
    Dado que o Usuario Esta Logado na Plataforma
    Sleep    1
    E Navega Ate o Perfil
    Sleep    1
    Set Global Variable    ${confirmPassword}    1234
    E Insere os Novos Dados do Perfil
    E Confirma o Envio do Formulario
    Sleep    1
    Entao Deve Mostrar os um Alerta Dizendo que os Dados Foram Atualizados
