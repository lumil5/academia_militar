package org.logistica.dao.interfaces;

import org.logistica.bean.entity.Usuario;

public interface UsuarioDAO {

    Usuario login(String usuario, String password);
}