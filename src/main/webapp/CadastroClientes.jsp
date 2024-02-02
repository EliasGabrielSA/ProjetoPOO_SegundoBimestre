<%-- 
    Document   : Formulario
    Created on : 19/06/2019, 10:42:39
    Author     : lefoly
--%>

<%@page import="controller.ClienteSrv"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Cliente"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario</title>
        <link rel="stylesheet" href=""/>
        <link
            href="https://fonts.googleapis.com/icon?family=Material+Icons"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="styles.css" type="text/css">
    </head>

    <%

        String acao = request.getParameter("acao");
        String id = request.getParameter("id");
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String telefone = request.getParameter("telefone");
        if (id == null||nome==null) {
            nome = "";
            email = "";
            telefone = "";
        }
        ClienteSrv clientSrv = new ClienteSrv();
        String list = clientSrv.listagem();
        
        



    %>

    <body>
        <div class="content">
            <nav class="navbar">
                <a href="index.jsp" class="logo">
                    <i class="material-icons">dataset</i>
                </a>
                <div>
                    <ul class="navlinks">
                        <li>
                            <a href="CadastroLivros.jsp?acao=inclusao"><i class="material-icons">book</i></a>
                            <div class="tooltip">Livros</div>
                        </li>
                        <li>
                            <a ><i class="material-icons">contacts</i></a>
                            <div class="tooltip">Clientes</div>
                        </li>

                    </ul>
                </div>
            </nav>
            <main>
                <div class="container">
                    <div class="header">
                        <h1>Clientes</h1>
                        <button id="btnCadastrar" onclick="showModal(modal)">
                            <span> Cadastrar Livro </span>
                        </button>
    

                    </div>
                    <div id="modal" class="modal">
                        <div class="modal-container">
                            <div class="modal-header-style">
                                <div class="modal-header">
                                    <h1>Cadastro de Clientes</h1>
                                    <button class="modal-close" id="btnModalClose" onclick= "limpaCamposCliente(modal)">
                                        <i class="material-icons">close</i>
                                    </button>
                                </div>
                                <p>Preencha os campos abaixo:</p>
                            </div>
                            <form action="ClienteSrv" method="POST">

                                <div class="modal-content">
                                    <input type="hidden" name="acao" value=<%=acao%>>
                                    <input type="hidden" name="id" value=<%=id%>>
                                    
                                    <label for="inpTitulo">Nome</label>
                                    <input type="text" oninput="verificaCampos(nome.value,email.value,telefone.value)"
                                           id="nome" name="nome" value="<%=nome%>"/>
                                    
                                    <label for="inpAutor">Email</label>
                                    <input type="text" oninput="verificaCampos(nome.value,email.value,telefone.value)"
                                           id="email" name="email" value="<%=email%>" />
                                    
                                    <label for="inpGenero">Telefone</label>
                                    <input type="text" oninput="verificaCampos(nome.value,email.value,telefone.value)"
                                           id="telefone" name="telefone" value="<%=telefone%>" />
                                    
                                    <input id="btnSalvar" type="submit" value="salvar"/>
                                </div>
                            </form>
                                    
                        </div>
                    </div>

                    <hr />

                    <div class="table-content">
                        <table>
                            <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Email</th>
                                    <th>Telefone</th>
                                    <th class="actions"> Ações</th>
                                </tr>
                            </thead>

                            <tbody id="bodyLivros">
                                <%= list%>
                            </tbody>
                        </table>
                    </div>

                </div>

            </main>
 <script>
    let acao= "<%=acao%>";
    if(acao==="edicao"){
       modal.style.display='block';
   }

    
    
    
</script>

        </div>
        <script src="./funcoes.js"></script>
    </body>
</html>

