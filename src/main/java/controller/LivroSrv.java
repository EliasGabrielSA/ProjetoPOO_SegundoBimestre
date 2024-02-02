package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import static java.lang.Double.parseDouble;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Livro;
import model.dao.InterfaceDao;
import model.dao.LivroDaoJpa;

/**
 *
 * @author heric
 */

public class LivroSrv extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String acao = request.getParameter("acao");
            String id = request.getParameter("id");
            String titulo = request.getParameter("titulo");
            String autor = request.getParameter("autor");
            Double preco=null;
            String precoString = request.getParameter("preco");
            if(precoString!= null){
                preco= parseDouble(precoString);
            }


            
            InterfaceDao dao = new LivroDaoJpa();
            RequestDispatcher rd;
            Livro l = null;
            

            
     



            switch (acao) {
                case "inclusao":
                    l = new Livro(titulo, autor, preco);
                    try {
                        dao.incluir(l);
                    } catch (Exception ex) {
                        System.out.println(ex.getMessage());
                    }
                    rd = request.getRequestDispatcher("CadastroLivros.jsp?acao=inclusao&lista=" + listagem());
                    rd.forward(request, response);
                    break;
                    
                

                case "pre-edicao":
                    l = (Livro) dao.pesquisarPorId(Integer.parseInt(id));
                   
                    rd = request.getRequestDispatcher("CadastroLivros.jsp?acao=edicao"
                            + "&id=" + l.getId()
                            + "&titulo=" +l.getTitulo()
                            + "&autor=" + l.getAutor()
                            + "&preco=" + l.getPreco());
                    rd.forward(request, response);
                    break;

                case "edicao":
                    
                    l = new Livro(titulo, autor, preco);
                    l.setId(Integer.parseInt(id));
                    try {
                        dao.editar(l);
                    } catch (Exception ex) {
                        System.out.println(ex.getMessage());
                    }
                    rd = request.getRequestDispatcher("CadastroLivros.jsp?acao=inclusao&lista=" + listagem());
                    rd.forward(request, response);
                    break;

                case "exclusao":
                    try {
                    l = new Livro();
                    l.setId(Integer.parseInt(id));
                    dao.excluir(l);
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
                rd = request.getRequestDispatcher("CadastroLivros.jsp?acao=inclusao&lista=" + listagem());
                rd.forward(request, response);
                break;

                case "listagem":
                    rd = request.getRequestDispatcher("CadastroLivros.jsp?acao=inclusao&lista=" + listagem());
                    rd.forward(request, response);
                    break;

                case "pesquisarPorTitulo":
                    rd = request.getRequestDispatcher("CadastroLivros.jsp?acao=inclusao&lista=" + listagemFiltrada(titulo));
                    rd.forward(request, response);
                    break;
            }
        } catch (Exception ex) {
            Logger.getLogger(LivroSrv.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String listagem() {
        InterfaceDao dao = new LivroDaoJpa();
        List<Livro> lista = null;
        try {
            lista = dao.listar();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        String listaHTML = "";
        for (Livro livro : lista) {
            listaHTML = listaHTML
                    + "<tr>"
                    + "<td>" + livro.getTitulo() + "</td>"
                    + "<td>" + livro.getAutor() + "</td>"
                    + "<td>" + livro.getPreco() + "</td>"
                    + "<td><form action=LivroSrv?acao=pre-edicao method='POST'>"
                    + "<input type='hidden' name='id' value="
                    + livro.getId() + "><input type='submit'class='btnBody' value=editar>"
                     + "<i class=\"material-icons\">assignment</i></form></td>"
                    + "</form></td>"
                    + "<form action=LivroSrv?acao=exclusao method='POST'>"
                    + "<td><input type='hidden' name='id' value="
                    + livro.getId() + "><input type='submit'class='btnBody' value=deletar><i class='material-icons'>delete</i></td>"
                    + "</form>"
                    + "</tr>";
        }
        return listaHTML;
    }

    public String listagemFiltrada(String titulo) {
        InterfaceDao dao = new LivroDaoJpa();
        List<Livro> lista = null;
        try {
            lista = dao.filtrarPorTitulo(titulo);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        String listaHTML = "";
        for (Livro livro : lista) {
            listaHTML = listaHTML
                    + "<tr>"
                    + "<td>" + livro.getTitulo() + "</td>"
                    + "<td>" + livro.getAutor() + "</td>"
                    + "<td>" + livro.getPreco() + "</td>"
                    + "<td><form action=livro?acao=pre-edicao method='POST'>"
                    + "<input type='hidden' name='id' value="
                    + livro.getId() + "><input type='submit' value=editar>"
                    + "</form></td>"
                    + "<form action=livroSrv?acao=exclusao method='POST'>"
                    + "<td><input type='hidden' name='id' value="
                    + livro.getId() + "><input type='submit' value=excluir></td>"
                    + "</form>"
                    + "</tr>";
        }
        return listaHTML;
    }
    public String listagemParcial() {
        InterfaceDao dao = new LivroDaoJpa();
        List<Livro> lista = null;
        try {
            lista = dao.listar();
        } catch (Exception ex) {
            System.out.println("mensagem de erro:"+ ex.getMessage());
        }
        String listaHTML = "";
        for (Livro livro : lista) {
            listaHTML = listaHTML
                    + "<tr>"
                    + "<td>" + livro.getTitulo() + "</td>"
                    + "<td>" + livro.getAutor() +
                    " </td> <td><button style='background-color: #ffd167' type='button' value='"+livro.getId()+"' class='btnLivro' >Selecionar </button></td>"
                    + "</tr>";
        }
            
        return listaHTML;
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
