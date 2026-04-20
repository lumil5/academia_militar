package org.logistica.util;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.logistica.bean.dto.MatriculaConsultaDTO;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public final class MatriculaPdfExport {

    private static final DateTimeFormatter DF = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    private MatriculaPdfExport() {
    }

    public static byte[] generar(List<MatriculaConsultaDTO> filas, String titulo) throws Exception {

        Document document = new Document(PageSize.A4.rotate(), 36, 36, 48, 36);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);

        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14);
        Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9);
        Font cellFont = FontFactory.getFont(FontFactory.HELVETICA, 8);

        document.open();

        String t = titulo != null ? titulo : "Reporte de matrículas";
        Paragraph pTitle = new Paragraph(t, titleFont);
        pTitle.setAlignment(Element.ALIGN_CENTER);
        pTitle.setSpacingAfter(14f);
        document.add(pTitle);

        PdfPTable table = new PdfPTable(new float[] { 1.1f, 1.2f, 1.7f, 1.9f, 2.2f, 1f, 1.2f, 0.9f });
        table.setWidthPercentage(100);
        table.setHeaderRows(1);

        String[] headers = { "ID", "Fecha", "DNI", "Nombres", "Apellidos", "Curso", "Ciclo", "Estado" };
        for (String h : headers) {
            PdfPCell c = new PdfPCell(new Phrase(h, headerFont));
            c.setHorizontalAlignment(Element.ALIGN_CENTER);
            c.setPadding(5f);
            table.addCell(c);
        }

        for (MatriculaConsultaDTO r : filas) {
            addCell(table, String.valueOf(r.getIdMatricula()), cellFont, Element.ALIGN_CENTER);
            addCell(table, r.getFechaMatricula() != null ? r.getFechaMatricula().toLocalDate().format(DF) : "",
                    cellFont, Element.ALIGN_CENTER);
            addCell(table, safe(r.getDniAlumno()), cellFont, Element.ALIGN_LEFT);
            addCell(table, safe(r.getNombresAlumno()), cellFont, Element.ALIGN_LEFT);
            addCell(table, safe(r.getApellidosAlumno()), cellFont, Element.ALIGN_LEFT);
            addCell(table, safe(r.getNombreCurso()), cellFont, Element.ALIGN_LEFT);
            addCell(table, safe(r.getCicloCurso()), cellFont, Element.ALIGN_CENTER);
            addCell(table, safe(r.getEstadoMatricula()), cellFont, Element.ALIGN_CENTER);
        }

        document.add(table);
        document.close();
        return baos.toByteArray();
    }

    private static void addCell(PdfPTable table, String text, Font font, int align) {
        PdfPCell c = new PdfPCell(new Phrase(text != null ? text : "", font));
        c.setHorizontalAlignment(align);
        c.setPadding(4f);
        table.addCell(c);
    }

    private static String safe(String s) {
        return s != null ? s : "";
    }
}
