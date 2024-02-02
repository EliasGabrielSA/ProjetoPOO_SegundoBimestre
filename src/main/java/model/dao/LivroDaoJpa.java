/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import model.Livro;

/**
 *
 * @author lefoly
 */
public class LivroDaoJpa implements InterfaceDao<Livro> {

    @Override
    public void incluir(Livro entidade) throws Exception {
        EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(entidade);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    @Override
    public void editar(Livro entidade) throws Exception {
        EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(entidade);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    @Override
    public void excluir(Livro entidade) throws Exception {
        EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();

            Livro l1 = em.find(Livro.class, entidade.getId());
            em.remove(l1);

            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }   

    @Override
    public Livro pesquisarPorId(int id) throws Exception {
        Livro l = null;
        EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();

            l = em.find(Livro.class, id);

            em.getTransaction().commit();
        } finally {
            em.close();
        }
        return l;
    }

    @Override
    public List<Livro> listar() throws Exception {
        List<Livro> lista = null;
        EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            lista = em.createQuery("FROM Livro l").getResultList();
            em.getTransaction().commit();
        } finally {
            em.close();
        }
        return lista;
    }

    @Override
    public List<Livro> filtrarPorTitulo(String titulo) throws Exception {
        EntityManager em = ConnFactory.getEntityManager();

        Query query = em.createNamedQuery("Livro.filtrarPorTitulo");
        query.setParameter("titulo", titulo);
        List<Livro> resultado = query.getResultList();
        return resultado;
    }

    @Override
    public List<Livro> filtrarPorNome(String nome) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }



    @Override
    public List<Livro> filtrarPorNomeOuTitulo(int id) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}


