package org.logistica.util;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.logistica.bean.dto.MatriculaConsultaDTO;

public final class MatriculaExcelExport {

    private static final DateTimeFormatter DF = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    private MatriculaExcelExport() {
    }

    public static byte[] generar(List<MatriculaConsultaDTO> filas) throws Exception {

        try (XSSFWorkbook wb = new XSSFWorkbook(); ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            Sheet sh = wb.createSheet("Matriculas");

            Row h = sh.createRow(0);
            String[] cols = { "ID Matrícula", "Fecha", "Estado", "ID Alumno", "DNI", "Nombres", "Apellidos",
                    "ID Curso", "Curso", "Ciclo" };
            for (int i = 0; i < cols.length; i++) {
                h.createCell(i).setCellValue(cols[i]);
            }

            int r = 1;
            for (MatriculaConsultaDTO row : filas) {
                Row x = sh.createRow(r++);
                int c = 0;
                x.createCell(c++).setCellValue(row.getIdMatricula());
                if (row.getFechaMatricula() != null) {
                    x.createCell(c++).setCellValue(row.getFechaMatricula().toLocalDate().format(DF));
                } else {
                    x.createCell(c++).setCellValue("");
                }
                x.createCell(c++).setCellValue(safe(row.getEstadoMatricula()));
                x.createCell(c++).setCellValue(row.getIdAlumno());
                x.createCell(c++).setCellValue(safe(row.getDniAlumno()));
                x.createCell(c++).setCellValue(safe(row.getNombresAlumno()));
                x.createCell(c++).setCellValue(safe(row.getApellidosAlumno()));
                x.createCell(c++).setCellValue(row.getIdCurso());
                x.createCell(c++).setCellValue(safe(row.getNombreCurso()));
                x.createCell(c).setCellValue(safe(row.getCicloCurso()));
            }

            for (int i = 0; i < cols.length; i++) {
                sh.autoSizeColumn(i);
            }

            wb.write(baos);
            return baos.toByteArray();
        }
    }

    private static String safe(String s) {
        return s != null ? s : "";
    }
}
