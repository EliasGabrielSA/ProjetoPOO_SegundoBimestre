<%-- 
    Document   : Formulario
    Created on : 19/06/2019, 10:42:39
    Author     : lefoly
--%>

<%@page import="controller.LivroSrv"%>
<%@page import="model.Livro"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Cliente"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CadastroLivros</title>
        <link rel="stylesheet" href=""/>
        <link
            href="https://fonts.googleapis.com/icon?family=Material+Icons"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="styles.css" type="text/css">
    </head>

    <%
        String id = request.getParameter("id");
        String acao = request.getParameter("acao");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String preco = request.getParameter("preco");
        System.out.println(titulo); 

        LivroSrv srv = new LivroSrv();
        String list = srv.listagem();
        
        if(id==null|| titulo==null){
        titulo="";
        autor="";
        preco="";
        }


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
                            <a><i class="material-icons">book</i></a>
                            <div class="tooltip">Livros</div>
                        </li>
                        <li>
                            <a href="CadastroClientes.jsp?acao=inclusao"><i class="material-icons">contacts</i></a>
                            <div class="tooltip">Clientes</div>
                        </li>
                    </ul>
                </div>
            </nav>
            <main>
                <div class="container">
                    <div class="header">
                        <h1>Livros</h1>

                        <button id="btnCadastrar" onclick="showModal(modal)">
                            <span> Cadastrar Livro </span>
                        </button>
                    </div>
                    <div id="modal" class="modal">
                        <div class="modal-container">
                            <div class="modal-header-style">
                                <div class="modal-header">
                                    <h1>Cadastro de Livros</h1>
                                    <button class="modal-close" id="btnModalClose" onclick="limpaCamposLivros(modal)">
                                        <i class="material-icons">close</i>
                                    </button>
                                </div>
                                <p>Preencha os campos abaixo:</p>
                            </div>
                            <form action="LivroSrv" method="POST">
                                <div class="modal-content">

                                    <input type="hidden" name="acao" value=<%=acao%>> 
                                    <input type="hidden" name="id" value=<%=id%>>

                                    <label for="inpTitulo">Título</label>
                                    <input type="text" oninput="verificaCampos(titulo.value,autor.value,preco.value)"
                                           name="titulo" id="titulo" value="<%=titulo%>" >

                                    <label for="inpAutor">Autor</label>
                                    <input type="text" oninput="verificaCampos(titulo.value,autor.value,preco.value)"
                                           name="autor" id="autor" value="<%=autor%> ">


                                    <label for="inpValor">Preco</label>
                                    <input type="number" oninput="verificaCampos(titulo.value,autor.value,preco.value)"
                                           name="preco" id="preco" value=<%=preco%> >

                                    <input type="submit" value="Salvar" id="btnSalvar">
                                </div>
                            </form>
                        </div>
                    </div>
                                    <hr/>             
                   
                    
                    <div class="table-content">                        
                        <table>
                            <thead>
                                <tr>
                                    <th>Título</th>
                                    <th>Autor(es)</th>
                                    <th>Preço</th>
                                    <<th>Ações</th>
                                </tr>
                            </thead>

                            <tbody id="bodyLivros">
                                <%=list%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
                                                <script>
                                 let acao = "<%=acao%>";
                                 if (acao === "edicao") {
                                     modal.style.display = 'block';
                                 }

                    </script>
        </div>
        <script src="./funcoes.js"></script>
    </body>
</html>

