<%-- 
    Document   : Formulario
    Created on : 19/06/2019, 10:42:39
    Author     : lefoly
--%>

<%@page import="controller.ClienteSrv"%>
<%@page import="controller.EmprestimoSrv"%>
<%@page import="controller.LivroSrv"%>
<%@page import="model.Livro"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Cliente"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Emprestimo</title>
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
        String cliente = request.getParameter("cliente");
        String livro = request.getParameter("livro");
        String dataDev = request.getParameter("dataDev");
        String clienteId = "";
        String livroId = "";
        ClienteSrv clienteSrv = new ClienteSrv();
        LivroSrv livroSrv = new LivroSrv();
        EmprestimoSrv empSrv = new EmprestimoSrv();

        String list = empSrv.listagem();
        if (acao == null) {
            acao = "inclusao";
        }
        if (id == null || cliente == null) {
            cliente = "";
            livro = "";
            dataDev = "";
        }
        String listaLivros = livroSrv.listagemParcial();
        String listaClientes = clienteSrv.listagemParcial();

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
                            <a href="CadastroClientes.jsp?acao=inclusao"><i class="material-icons">contacts</i></a>
                            <div class="tooltip">Clientes</div>
                        </li>
                    </ul>   
                </div>
            </nav>
            <main>
                <div class="container">
                    <div class="header">
                        <h1>Emprestimos</h1>

                        <button id="btnCadastrar" onclick="showModal(modal)">
                            <span> Novo Emprestimo </span>
                        </button>
                    </div>
                    <div id="modal" class="modal">
                        <div class="modal-container">
                            <div class="modal-header-style">
                                <div class="modal-header">
                                    <h1>Realizar de Emprestimos</h1>
                                    <button class="modal-close" id="btnModalClose" onclick="limpaCamposEmprestimo(modal)">
                                        <i class="material-icons">close</i>
                                    </button>
                                </div>
                                <p>Preencha os campos abaixo:</p>
                            </div>
                            <form action="EmprestimoSrv" method="POST">
                                <div class="modal-content">

                                    <input type="hidden" name="acao" value=<%=acao%>> 
                                    <input type="hidden" name="id" value=<%=id%>>
                                    <input type="hidden" name="clienteId" id='clienteId' value=<%=clienteId%>>
                                    <input type="hidden" name="livroId" id='livroId' value=<%=livroId%>>

                                    <label for="inpTitulo">Cliente</label>
                                    <input type="text" oninput="filtraElem(cliente.value, '#tbodyModalCliente tr')"
                                           name="cliente" id="cliente" value="<%=cliente%>">
                                    <div class="table-content">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Nome</th>
                                                    <th>Email</th>
                                                    <th>selecao</th>
                                                </tr>
                                            </thead>
                                            <tbody id='tbodyModalCliente' >
                                                <%= listaClientes%>
                                            </tbody>
                                        </table>
                                    </div>

                                    <label for="inpAutor">Titulo do Livro</label>   

                                    <input type="text" oninput="filtraElem(livro.value, '#tbodyModalLivro tr')"
                                           name="livro" id="livro" value="<%=livro%>" >
                                    <div class="table-content">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>titulo</th>
                                                    <th>autor</th>
                                                    <th>selecao</th>
                                                </tr>           
                                            </thead>
                                            <tbody id='tbodyModalLivro' >
                                                <%= listaLivros%>
                                            </tbody>
                                        </table>
                                    </div>


                                    <label for="inpValor">data Devolução</label>
                                    <input type="date" onchange="verificaCampos(clienteId.value, livroId.value, data.value)"
                                           name="data" id="data" value=<%=dataDev%> >

                                    <input type="submit" value="Salvar" id="btnSalvar">
                                </div>
                            </form>

                        </div>
                    </div>

                    <hr>

                    <div class="table-content">
                        <table>
                            <thead>
                                <tr>
                                    <th>Cliente</th>
                                    <th>Livro(es)</th>
                                    <th>DataDev</th>
                                    <th>Acões</th>
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
                document.addEventListener("DOMContentLoaded", function () {
                    let acao = "<%=acao%>";
                    let btnCliente = document.querySelectorAll(".btnCliente");
                    let btnLivro = document.querySelectorAll(".btnLivro");
                    let clienteId = document.querySelector("#clienteId");
                    let livroId = document.querySelector("#livroId");
                    let modal = document.querySelector("#modal");
                    if (acao === "edicao") {
                        showModal(modal);
                    }

                    btnCliente.forEach((btn) => {
                        btn.onclick = function () {
                            clienteId.value = this.value;
                            verificaCampos(clienteId.value, livroId.value, data.value);
                        };
                    });
                    btnLivro.forEach((btn) => {
                        btn.onclick = function () {
                            livroId.value = this.value;
                            verificaCampos(clienteId.value, livroId.value, data.value);
                        };
                    });
                });


            </script>

        </div>
        <script src="./funcoes.js"></script>
    </body>
</html>

