package org.logistica.dao.interfaces;

import java.util.List;
import org.logistica.bean.entity.Retiro;

public interface RetiroDAO {

    public List<Retiro> listar();
    public int registrar(Retiro r);
}