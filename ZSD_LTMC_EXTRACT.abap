*&---------------------------------------------------------------------*
*& Report  ZSD_LTMC_EXTRACT
*&---------------------------------------------------------------------*
*& Extract OPEN Sales Order data and display it in a ALV
*&---------------------------------------------------------------------*

REPORT zsd_ltmc_extract.

TABLES: vbak, vbap, vbup.

SELECTION-SCREEN BEGIN OF BLOCK main WITH FRAME TITLE text-t01.
SELECT-OPTIONS:
  s_vbeln FOR vbak-vbeln,
  s_erdat FOR vbak-erdat,
  s_audat FOR vbak-audat,
  s_vbtyp FOR vbak-vbtyp,
  s_trvog FOR vbak-trvog,
  s_auart FOR vbak-auart,
  s_augru FOR vbak-augru,
  s_lifsk FOR vbak-lifsk,
  s_faksk FOR vbak-faksk,
  s_vkorg FOR vbak-vkorg,
  s_vtweg FOR vbak-vtweg,
  s_spart FOR vbak-spart,
  s_kunnr FOR vbak-kunnr.
SELECTION-SCREEN BEGIN OF BLOCK item_data WITH FRAME TITLE text-t02.
SELECT-OPTIONS:
  s_matnr FOR vbap-matnr,
  s_matkl FOR vbap-matkl,
  s_pstyv FOR vbap-pstyv,
  s_vstel FOR vbap-vstel,
  s_werks FOR vbap-werks.
SELECTION-SCREEN END OF BLOCK item_data.
SELECTION-SCREEN BEGIN OF BLOCK item_status WITH FRAME TITLE text-t03.
SELECT-OPTIONS:
  s_lfsta FOR vbup-lfsta,
  s_wbsta FOR vbup-wbsta,
  s_lfgsa FOR vbup-lfgsa DEFAULT 'B' SIGN E OPTION EQ,
  s_gbsta FOR vbup-gbsta.
SELECTION-SCREEN END OF BLOCK item_status.
SELECTION-SCREEN END OF BLOCK main.

TYPES:
  BEGIN OF ty_header_data,
    vbeln       TYPE vbak-vbeln,
    auart       TYPE vbak-auart,
    vkorg       TYPE vbak-vkorg,
    vtweg       TYPE vbak-vtweg,
    spart       TYPE vbak-spart,
    vkbur       TYPE vbak-vkbur,
    vkgrp       TYPE vbak-vkgrp,
    bstnk       TYPE vbak-bstnk,
    vdatu       TYPE vbak-vdatu,
    bstdk       TYPE vbak-bstdk,
    faksk       TYPE vbak-faksk,
    augru       TYPE vbak-augru,
    price_date  TYPE vbkd-prsdt,
    exchg_rate  TYPE vbkd-kursk,
    audat       TYPE vbak-audat,
    incov       TYPE vbkd-incov,
    inco1       TYPE vbkd-inco1,
    inco2_l     TYPE vbkd-inco2,
    inco2       TYPE vbkd-inco2,
    inco3_l     TYPE vbkd-inco3_l,
    zterm       TYPE vbkd-zterm,
    bill_sched  TYPE vbkd-perfk,
    wbs_elem    TYPE vbak-ps_psp_pnr,
    name        TYPE vbak-bname,
    telephone   TYPE vbak-telf1,
    kvgr1       TYPE vbak-kvgr1,
    kvgr2       TYPE vbak-kvgr2,
    kvgr3       TYPE vbak-kvgr3,
    kvgr4       TYPE vbak-kvgr4,
    kvgr5       TYPE vbak-kvgr5,
    cond_handle TYPE char10, "See SAP Note 593246
  END OF ty_header_data,

  BEGIN OF ty_header_conditions,
    vbeln TYPE vbak-vbeln,
    kschl TYPE konv-kschl,
    kbetr TYPE konv-kbetr,
    konwa TYPE konv-waers,
    kpein TYPE konv-kpein,
    kmein TYPE konv-kmein,
  END OF ty_header_conditions,

  BEGIN OF ty_header_texts,
    vbeln      TYPE vbak-vbeln,
    tdspras    TYPE rstxt-tdspras,
    tdid       TYPE rstxt-tdid,
    text_lines TYPE tdline,
  END OF ty_header_texts,

  BEGIN OF ty_item_data,
    vbeln      TYPE vbap-vbeln,
    posnr      TYPE vbap-posnr,
    hg_lv_item TYPE vbap-uepos,
    posex      TYPE vbap-posex,
    matnr      TYPE vbap-matnr,
    zieme      TYPE vbap-zieme,
    umziz      TYPE vbap-umziz,
    umzin      TYPE vbap-umzin,
    charg      TYPE vbap-charg,
    werks      TYPE vbap-werks,
    lgort      TYPE vbap-lgort,
    pstyv      TYPE vbap-pstyv,
    short_text TYPE vbap-arktx,
    incov      TYPE vbkd-incov,
    inco1      TYPE vbkd-inco1,
    inco2_l    TYPE vbkd-inco2_l,
    inco2      TYPE vbkd-inco2,
    inco3_l    TYPE vbkd-inco3_l,
    zterm      TYPE vbkd-zterm,
    kokrs      TYPE vbak-kokrs,
    profit_ctr TYPE vbap-prctr,
    wbs_elem   TYPE vbap-ps_psp_pnr,
  END OF ty_item_data,

  BEGIN OF ty_item_conditions,
    vbeln TYPE vbap-vbeln,
    posnr TYPE vbap-posnr,
    kschl TYPE konv-kschl,
    kbetr TYPE konv-kbetr,
    konwa TYPE konv-waers,
    kpein TYPE konv-kpein,
    kmein TYPE konv-kmein,
  END OF ty_item_conditions,

  BEGIN OF ty_item_texts,
    vbeln      TYPE vbak-vbeln,
    posnr      TYPE vbap-posnr,
    tdspras    TYPE rstxt-tdspras,
    tdid       TYPE rstxt-tdid,
    text_lines TYPE tdline,
  END OF ty_item_texts,

  BEGIN OF ty_partner,
    vbeln         TYPE vbpa-vbeln,
    posnr         TYPE vbpa-posnr,
    parvw         TYPE vbpa-parvw,
    kunnr         TYPE vbpa-kunnr,
    extaddrnumber TYPE vbpa-adrnr,
    street        TYPE adrc-street,
    postl_code    TYPE adrc-post_code1,
    city          TYPE adrc-city1,
    country       TYPE adrc-country,
    region        TYPE adrc-region,
    tel_number    TYPE adrc-tel_number,
    fax_number    TYPE adrc-fax_number,
    name1         TYPE adrc-name1,
  END OF ty_partner,

  BEGIN OF ty_schedule_line,
    vbeln TYPE vbep-vbeln,
    posnr TYPE vbep-posnr,
    etenr TYPE vbep-etenr,
    wmeng TYPE vbep-wmeng,
    etdat TYPE vbep-edatu,
  END OF ty_schedule_line,

  BEGIN OF ty_open_item,
    vbeln TYPE vbak-vbeln,
    posnr TYPE vbap-posnr,
    etenr TYPE vbep-etenr,
  END OF ty_open_item.

DATA gt_open_items TYPE TABLE OF ty_open_item.

DATA: gt_header_data       TYPE TABLE OF ty_header_data,
      gt_header_conditions TYPE TABLE OF ty_header_conditions,
      gt_header_texts      TYPE TABLE OF ty_header_texts,
      gt_item_data         TYPE TABLE OF ty_item_data,
      gt_item_conditions   TYPE TABLE OF ty_item_conditions,
      gt_item_texts        TYPE TABLE OF ty_item_texts,
      gt_partner           TYPE TABLE OF ty_partner,
      gt_schedule_line     TYPE TABLE OF ty_schedule_line.

DATA: go_salv_table      TYPE REF TO cl_salv_table,
      go_splitter        TYPE REF TO cl_gui_splitter_container,
      go_container_right TYPE REF TO cl_gui_container,
      go_container_left  TYPE REF TO cl_gui_container.

CLASS lcl_events DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS:
      get_data,
      get_header_data,
      get_header_conditions,
      get_header_texts,
      get_item_data,
      get_item_conditions,
      get_item_texts,
      get_partner_data,
      get_schedule_line_data,
      display_data
        CHANGING
          pt_data TYPE ANY TABLE,
      build_gui,
      on_clicked FOR EVENT clicked OF cl_gui_container_bar_2
        IMPORTING
            id
            container ##NEEDED
            sender ##NEEDED.

ENDCLASS.

CLASS lcl_events IMPLEMENTATION.

  METHOD get_data.

    SELECT vbak~vbeln, vbap~posnr, vbep~etenr
      FROM vbak
      INNER JOIN vbuk ON vbuk~vbeln = vbak~vbeln
      INNER JOIN vbap ON vbap~vbeln = vbak~vbeln
      INNER JOIN vbup ON vbup~vbeln = vbap~vbeln AND vbup~posnr = vbap~posnr
      "Left join VBEP added here for comparison against VA05.
      "VBEP not needed for LTMC extract.
      LEFT JOIN vbep ON vbep~vbeln = vbap~vbeln AND vbep~posnr = vbap~posnr
      INTO TABLE @gt_open_items
      WHERE vbak~vbeln IN @s_vbeln[]
              AND vbak~erdat IN @s_erdat
              AND vbak~audat IN @s_audat
              AND vbak~vbtyp IN @s_vbtyp
              AND vbak~trvog IN @s_trvog
              AND vbak~auart IN @s_auart
              AND vbak~augru IN @s_augru
              AND vbak~lifsk IN @s_lifsk
              AND vbak~faksk IN @s_faksk
              AND vbak~vkorg IN @s_vkorg
              AND vbak~vtweg IN @s_vtweg
              AND vbak~spart IN @s_spart
              AND vbak~kunnr IN @s_kunnr
              AND vbap~matnr IN @s_matnr
              AND vbap~matkl IN @s_matkl
              AND vbap~pstyv IN @s_pstyv
              AND vbap~vstel IN @s_vstel
              AND vbap~werks IN @s_werks
              AND vbup~lfsta IN @s_lfsta
              AND vbup~wbsta IN @s_wbsta
              AND vbup~lfgsa IN @s_lfgsa
              AND vbup~gbsta IN @s_gbsta
            "Logic from form VBAP_SELECT_ALL of FM RV_SALES_DOCUMENT_VIEW_3,
            "which is called within VA05.
              AND vbap~matnr NE @space AND
            "Logic from form STATUS_VBUP of FM RV_SALES_DOCUMENT_VIEW_3,
            "which is called within VA05.
            ( ( vbak~trvog = '0' AND
                vbup~lfgsa IN (' ','C') AND      "Overall dlv.st.
                vbup~gbsta IN ('A','B') ) OR     "Overall status
              ( vbak~trvog = '0' AND
                vbup~lfgsa IN ('A','B') AND      "Overall dlv.st.
                vbup~gbsta NE 'C' )  OR          "Overall status
              ( vbak~trvog IN ('1','2') AND
                vbup~rfgsa IN ('A','B') ) OR     "Reference stat.
              ( vbak~trvog = '3' AND
                vbup~lfgsa = ' ' AND             "Overall dlv.st.
                vbup~gbsta IN ('A','B') ) OR     "Overall status
              ( vbak~trvog = '3' AND
                vbup~lfgsa IN ('A','B') ) OR     "Overall dlv.st.
              ( vbak~trvog IN ('4','5','B') AND
                vbup~gbsta IN ('A','B') ) ).     "Overall status

    get_header_data( ).
    get_header_conditions(  ).
    get_header_texts(  ).
    get_item_data(  ).
    get_item_conditions(  ).
    get_item_texts( ).
    get_partner_data(  ).
    get_schedule_line_data(  ).

  ENDMETHOD.

  METHOD get_header_data.

    CHECK gt_open_items IS NOT INITIAL.

    SELECT
      vbak~vbeln,
      vbak~auart,
      vbak~vkorg,
      vbak~vtweg,
      vbak~spart,
      vbak~vkbur,
      vbak~vkgrp,
      vbak~bstnk,
      vbak~vdatu,
      vbak~bstdk,
      vbak~faksk,
      vbak~augru,
      vbkd~prsdt AS price_date,
      vbkd~kursk AS exchg_rate,
      vbak~audat,
      vbkd~incov,
      vbkd~inco1,
      vbkd~inco2_l,
      vbkd~inco2,
      vbkd~inco3_l,
      vbkd~zterm,
      vbkd~perfk AS bill_sched,
      vbak~ps_psp_pnr AS wbs_elem,
      vbak~bname AS name,
      vbak~telf1 AS telephone,
      vbak~kvgr1,
      vbak~kvgr2,
      vbak~kvgr3,
      vbak~kvgr4,
      vbak~kvgr5
      FROM vbak
      INNER JOIN vbkd
        ON vbkd~vbeln = vbak~vbeln AND
           vbkd~posnr = '000000'
      INTO CORRESPONDING FIELDS OF TABLE @gt_header_data
      FOR ALL ENTRIES IN @gt_open_items
      WHERE vbak~vbeln = @gt_open_items-vbeln.

  ENDMETHOD.

  METHOD get_header_conditions.

    CHECK gt_open_items IS NOT INITIAL.

    SELECT vbeln, knumv
      FROM vbak
      INTO TABLE @DATA(lt_vbak)
      FOR ALL ENTRIES IN @gt_open_items
      WHERE vbak~vbeln = @gt_open_items-vbeln.

    CHECK lt_vbak IS NOT INITIAL.

    SELECT *
      FROM konv
      INTO TABLE @DATA(lt_konv)
      FOR ALL ENTRIES IN @lt_vbak
      WHERE konv~knumv = @lt_vbak-knumv AND
            konv~kposn = '000000' AND
            konv~kinak = @abap_false.
    "Should KONV-KSTAT be considered?

    CHECK lt_konv IS NOT INITIAL.

    "Prepare for BINARY SEARCH
    SORT lt_vbak BY knumv.

    LOOP AT lt_konv INTO DATA(ls_konv).

      READ TABLE lt_vbak
        INTO DATA(ls_vbak)
        WITH KEY knumv = ls_konv-knumv
                 BINARY SEARCH.
      IF sy-subrc EQ 0.
        APPEND INITIAL LINE TO gt_header_conditions
          ASSIGNING FIELD-SYMBOL(<ls_header_conditions>).
        <ls_header_conditions>-vbeln = ls_vbak-vbeln.
        <ls_header_conditions>-kschl = ls_konv-kschl.
        <ls_header_conditions>-kbetr = ls_konv-kbetr.
        <ls_header_conditions>-konwa = ls_konv-waers.
        <ls_header_conditions>-kpein = ls_konv-kpein.
        <ls_header_conditions>-kmein = ls_konv-kmein.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_header_texts.

    CHECK gt_header_data IS NOT INITIAL.

    DATA:
      lt_tdname TYPE TABLE OF stxh-tdname,
      lt_stxh   TYPE TABLE OF stxh,
      ls_header TYPE          thead ##NEEDED,
      lt_lines  TYPE TABLE OF tline.

    "Build table of text keys
    LOOP AT gt_header_data INTO DATA(ls_header_data).
      APPEND ls_header_data-vbeln TO lt_tdname.
    ENDLOOP.

    SELECT *
      FROM stxh
      INTO CORRESPONDING FIELDS OF TABLE lt_stxh
      FOR ALL ENTRIES IN lt_tdname
      WHERE tdobject = 'VBBK' AND
            tdname = lt_tdname-table_line AND
            tdspras = sy-langu.

    LOOP AT lt_stxh INTO DATA(ls_stxh).
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          id        = ls_stxh-tdid
          language  = ls_stxh-tdspras
          name      = ls_stxh-tdname
          object    = ls_stxh-tdobject
        IMPORTING
          header    = ls_header
        TABLES
          lines     = lt_lines
        EXCEPTIONS
          id        = 1
          language  = 2
          name      = 3
          object    = 4
          not_found = 5
          OTHERS    = 6.
      IF sy-subrc NE 0 OR lt_lines[] IS INITIAL.
        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO gt_header_texts
       ASSIGNING FIELD-SYMBOL(<ls_header_text>).

      <ls_header_text>-vbeln = ls_stxh-tdname.
      <ls_header_text>-tdid = ls_stxh-tdid.
      <ls_header_text>-tdspras = ls_stxh-tdspras.

      LOOP AT lt_lines INTO DATA(ls_line).
        IF <ls_header_text>-text_lines IS INITIAL.
          <ls_header_text>-text_lines = ls_line-tdline.
        ELSE.
          " Use SEPARATED BY SPACE to maintain word spacing between lines
          CONCATENATE <ls_header_text>-text_lines ls_line-tdline
           INTO <ls_header_text>-text_lines
           SEPARATED BY space.
        ENDIF.
      ENDLOOP.

      CLEAR: lt_lines.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_item_data.

    CHECK gt_open_items IS NOT INITIAL.

    SELECT
      vbap~vbeln,
      vbap~posnr,
      vbap~uepos AS hg_lv_item,
      vbap~posex,
      vbap~matnr,
      vbap~zieme,
      vbap~umziz,
      vbap~umzin,
      vbap~charg,
      vbap~werks,
      vbap~lgort,
      vbap~pstyv,
      vbap~arktx AS short_text,
      vbak~kokrs,
      vbap~prctr AS profit_ctr,
      vbap~ps_psp_pnr AS wbs_elem
    FROM vbap
    INNER JOIN vbak ON vbak~vbeln = vbap~vbeln
    INTO CORRESPONDING FIELDS OF TABLE @gt_item_data
    FOR ALL ENTRIES IN @gt_open_items
    WHERE vbap~vbeln = @gt_open_items-vbeln
      AND vbap~posnr = @gt_open_items-posnr.

    SELECT vbeln, posnr, incov, inco1, inco2_l, inco2, vbkd~inco3_l, zterm
      FROM vbkd
      INTO TABLE @DATA(lt_vbkd)
      FOR ALL ENTRIES IN @gt_open_items
      WHERE ( vbeln = @gt_open_items-vbeln
        AND posnr = @gt_open_items-posnr )
        OR ( vbeln = @gt_open_items-vbeln
        AND posnr = '000000' )
        ORDER BY PRIMARY KEY.

    LOOP AT gt_item_data ASSIGNING FIELD-SYMBOL(<ls_item_data>).

      READ TABLE lt_vbkd
        INTO DATA(ls_vbkd)
        WITH KEY vbeln = <ls_item_data>-vbeln
                 posnr = <ls_item_data>-posnr
                 BINARY SEARCH.
      IF sy-subrc <> 0.
        READ TABLE lt_vbkd
          INTO ls_vbkd
          WITH KEY vbeln = <ls_item_data>-vbeln
                   posnr = '000000'
                   BINARY SEARCH.
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.
      ENDIF.

      <ls_item_data>-incov = ls_vbkd-incov.
      <ls_item_data>-inco1 = ls_vbkd-inco1.
      <ls_item_data>-inco2_l = ls_vbkd-inco2_l.
      <ls_item_data>-inco2 = ls_vbkd-inco2.
      <ls_item_data>-inco3_l = ls_vbkd-inco3_l.
      <ls_item_data>-zterm = ls_vbkd-zterm.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_item_conditions.

    CHECK gt_open_items IS NOT INITIAL.

    SELECT vbak~knumv, vbap~posnr, vbap~vbeln
      FROM vbap
      INNER JOIN vbak ON vbak~vbeln = vbap~vbeln
      INTO TABLE @DATA(lt_vbak_vbap)
      FOR ALL ENTRIES IN @gt_open_items
      WHERE vbap~vbeln = @gt_open_items-vbeln AND
            vbap~posnr = @gt_open_items-posnr.

    CHECK lt_vbak_vbap IS NOT INITIAL.

    SELECT *
      FROM konv
      INTO TABLE @DATA(lt_konv)
      FOR ALL ENTRIES IN @lt_vbak_vbap
      WHERE konv~knumv = @lt_vbak_vbap-knumv AND
            konv~kposn = @lt_vbak_vbap-posnr AND
            konv~kinak = @abap_false.
    "Should KONV-KSTAT be considered?

    CHECK lt_konv IS NOT INITIAL.

    "Prepare for BINARY SEARCH
    SORT lt_vbak_vbap BY knumv posnr.

    LOOP AT lt_konv INTO DATA(ls_konv).
      READ TABLE lt_vbak_vbap
      INTO DATA(ls_vbak_vbap)
      WITH KEY knumv = ls_konv-knumv
               posnr = ls_konv-kposn
               BINARY SEARCH.
      IF sy-subrc EQ 0.
        APPEND INITIAL LINE TO gt_item_conditions
          ASSIGNING FIELD-SYMBOL(<ls_item_conditions>).
        <ls_item_conditions>-vbeln = ls_vbak_vbap-vbeln.
        <ls_item_conditions>-posnr = ls_vbak_vbap-posnr.
        <ls_item_conditions>-kschl = ls_konv-kschl.
        <ls_item_conditions>-kbetr = ls_konv-kbetr.
        <ls_item_conditions>-konwa = ls_konv-waers.
        <ls_item_conditions>-kpein = ls_konv-kpein.
        <ls_item_conditions>-kmein = ls_konv-kmein.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_item_texts.

    CHECK gt_item_data IS NOT INITIAL.

    DATA:
      lt_tdname TYPE TABLE OF stxh-tdname,
      lt_stxh   TYPE TABLE OF stxh,
      ls_header TYPE          thead ##NEEDED,
      lt_lines  TYPE TABLE OF tline.

    "Build table of text keys
    LOOP AT gt_item_data INTO DATA(ls_item_data).
      APPEND ls_item_data-vbeln && ls_item_data-posnr TO lt_tdname.
    ENDLOOP.

    SELECT *
      FROM stxh
      INTO CORRESPONDING FIELDS OF TABLE lt_stxh
      FOR ALL ENTRIES IN lt_tdname
      WHERE tdobject = 'VBBP' AND
            tdname = lt_tdname-table_line AND
            tdspras = sy-langu.

    LOOP AT lt_stxh INTO DATA(ls_stxh).
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          id        = ls_stxh-tdid
          language  = ls_stxh-tdspras
          name      = ls_stxh-tdname
          object    = ls_stxh-tdobject
        IMPORTING
          header    = ls_header
        TABLES
          lines     = lt_lines
        EXCEPTIONS
          id        = 1
          language  = 2
          name      = 3
          object    = 4
          not_found = 5
          OTHERS    = 6.
      IF sy-subrc NE 0 OR lt_lines[] IS INITIAL.
        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO gt_item_texts
        ASSIGNING FIELD-SYMBOL(<ls_item_text>).

      <ls_item_text>-vbeln = ls_stxh-tdname(10).
      "posnr is 6 characters long with leading zeros
      <ls_item_text>-posnr = ls_stxh-tdname+10(6).
      <ls_item_text>-tdid = ls_stxh-tdid.
      <ls_item_text>-tdspras = ls_stxh-tdspras.
      LOOP AT lt_lines INTO DATA(ls_line).
        IF <ls_item_text>-text_lines IS INITIAL.
          <ls_item_text>-text_lines = ls_line-tdline.
        ELSE.
          " Use SEPARATED BY SPACE to maintain word spacing between lines
          CONCATENATE <ls_item_text>-text_lines ls_line-tdline
           INTO <ls_item_text>-text_lines
           SEPARATED BY space.
        ENDIF.
      ENDLOOP.

      CLEAR: lt_lines.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_partner_data.

    CHECK gt_open_items IS NOT INITIAL.

    SELECT
      vbpa~vbeln,
      vbpa~posnr,
      vbpa~parvw,
      vbpa~kunnr,
      vbpa~adrnr AS extaddrnumber,
      adrc~street,
      adrc~post_code1 AS postl_code,
      adrc~city1 AS city,
      adrc~country,
      adrc~region,
      adrc~tel_number,
      adrc~fax_number,
      adrc~name1
    FROM vbpa
    INNER JOIN adrc
      ON adrc~addrnumber = vbpa~adrnr
    INTO CORRESPONDING FIELDS OF TABLE @gt_partner
    FOR ALL ENTRIES IN @gt_open_items
    WHERE ( vbpa~vbeln = @gt_open_items-vbeln AND
            vbpa~posnr = @gt_open_items-posnr ) OR
          ( vbpa~vbeln = @gt_open_items-vbeln AND
            posnr = '000000' ).

  ENDMETHOD.

  METHOD get_schedule_line_data.

    CHECK gt_open_items IS NOT INITIAL.

    SELECT vbeln posnr etenr wmeng edatu AS etdat
      FROM vbep
      INTO CORRESPONDING FIELDS OF TABLE gt_schedule_line
      FOR ALL ENTRIES IN gt_open_items
      WHERE vbep~vbeln = gt_open_items-vbeln AND
            vbep~posnr = gt_open_items-posnr.

  ENDMETHOD.

  METHOD build_gui.

    TRY.
* Create a vertical splitter
        CREATE OBJECT go_splitter
          EXPORTING
            parent                  = cl_gui_container=>default_screen
            rows                    = 1
            columns                 = 2
            no_autodef_progid_dynnr = abap_true.

* 10% / 90% Split
        go_splitter->set_column_width( id = 1 width = 10 ).
        go_container_left = go_splitter->get_container( row = 1 column = 1 ).
        go_container_right = go_splitter->get_container( row = 1 column = 2 ).

        DATA(it_captions) =
          VALUE sbptcaptns(
            ( caption      = 'Header Data'
              icon         = icon_list
              name         = 'CAP1' )
              ( caption      = 'Header Conditons'
              icon         = icon_list
              name         = 'CAP2' )
              ( caption      = 'Header Texts'
              icon         = icon_list
              name         = 'CAP3' )
              ( caption      = 'Item Data'
              icon         = icon_list
              name         = 'CAP4' )
              ( caption      = 'Item Conditions'
              icon         = icon_list
              name         = 'CAP5' )
              ( caption      = 'Item Texts'
              icon         = icon_list
              name         = 'CAP6' )
              ( caption      = 'Partner'
              icon         = icon_list
              name         = 'CAP7' )
              ( caption      = 'Schedule Line Data'
              icon         = icon_list
              name         = 'CAP8' ) ).

* Create a cl_gui_container_bar in the left splitter
        DATA(o_toolbar) =
          NEW cl_gui_container_bar_2(
            active_id     = 1                " Number of active entry
            parent        = go_container_left " Place in left corner
            captions      = it_captions
            style = cl_gui_container_bar_2=>c_style_tile "c_style_fixed
            close_buttons = abap_false ).   " Tool bar entries

* Register an event handler
        SET HANDLER lcl_events=>on_clicked FOR o_toolbar.

* Display sample data in the right-hand pane
        display_data( CHANGING pt_data = gt_header_data ).

* Hide the empty default toolbar
        cl_abap_list_layout=>suppress_toolbar( ).

* Force the display of cl_gui_container=>default_screen
        WRITE: space.

      CATCH cx_root ##NO_HANDLER ##CATCH_ALL.
    ENDTRY.

  ENDMETHOD.
  METHOD on_clicked.

    CASE id.
      WHEN 1. " display header data
        lcl_events=>display_data( CHANGING pt_data = gt_header_data ).
      WHEN 2. " display header conditions
        lcl_events=>display_data( CHANGING pt_data = gt_header_conditions ).
      WHEN 3. " display header texts
        lcl_events=>display_data( CHANGING pt_data = gt_header_texts ).
      WHEN 4. " display item data
        lcl_events=>display_data( CHANGING pt_data = gt_item_data ).
      WHEN 5. " display item conditions
        lcl_events=>display_data( CHANGING pt_data = gt_item_conditions ).
      WHEN 6. " display item texts
        lcl_events=>display_data( CHANGING pt_data = gt_item_texts ).
      WHEN 7. " display partner data
        lcl_events=>display_data( CHANGING pt_data = gt_partner ).
      WHEN 8. " display schedule line data
        lcl_events=>display_data( CHANGING pt_data = gt_schedule_line ).
    ENDCASE.

  ENDMETHOD.

  METHOD display_data.
    " generic method to display data in the right-hand pane

    DATA:
      lt_key_fields       TYPE STANDARD TABLE OF lvc_fname WITH EMPTY KEY,
      lt_highlight_fields TYPE STANDARD TABLE OF lvc_fname WITH EMPTY KEY.

    TRY.
        lt_highlight_fields = VALUE #(
          ( 'AUART' )
          ( 'VKORG' )
          ( 'VTWEG' )
          ( 'SPART' )
          ( 'VDATU' )
          ( 'KSCHL' )
          ( 'TEXTLINE' )
          ( 'TEXT_LINES' )
          ( 'POSNR' )
          ( 'MATNR' )
          ( 'WMENG' ) ).


        lt_key_fields = VALUE #(
          ( 'VBELN' )
          ( 'POSNR' )
          ( 'ETENR' )
          ( 'TDID' )
          ( 'TDSPRAS' )
          ( 'PARVW' )
          ( 'KUNNR' ) ).

        IF go_salv_table IS NOT BOUND.
          cl_salv_table=>factory( EXPORTING
                                    r_container    = go_container_right
                                  IMPORTING
                                    r_salv_table   = go_salv_table
                                  CHANGING
                                    t_table        = gt_header_data ).
        ENDIF.

        go_salv_table->set_data( CHANGING t_table = pt_data ).
        go_salv_table->get_functions( )->set_all( ).

        "Global Display Settings
        DATA(lo_display) = go_salv_table->get_display_settings( ).
        lo_display->set_striped_pattern( if_salv_c_bool_sap=>true ).

        "Table Selection Settings
        DATA(lo_select) = go_salv_table->get_selections( ).
        lo_select->set_selection_mode( if_salv_c_selection_mode=>row_column ).

        "(Re)apply column settings for the currently bound table
        DATA(lo_columns) = go_salv_table->get_columns( ).
        lo_columns->set_optimize( if_salv_c_bool_sap=>true ).
        lo_columns->set_key_fixation( if_salv_c_bool_sap=>true ).

        " Highlight key fields defined in the migration template
        LOOP AT lt_key_fields INTO DATA(lv_key_field).
          TRY.
              DATA(lo_col) =
                CAST cl_salv_column_table(
                  lo_columns->get_column( lv_key_field ) ).
              lo_col->set_key( abap_true ).
            CATCH cx_salv_not_found ##NO_HANDLER.
          ENDTRY.
        ENDLOOP.

        " Highlight mandatory fields defined in the migration template
        LOOP AT lt_highlight_fields INTO DATA(lv_highlight_field).
          TRY.
              lo_col =
                CAST cl_salv_column_table(
                  lo_columns->get_column( lv_highlight_field ) ).
              lo_col->set_color( VALUE lvc_s_colo( col = 3 ) ).
            CATCH cx_salv_not_found ##NO_HANDLER.
          ENDTRY.
        ENDLOOP.

        go_salv_table->refresh( refresh_mode = if_salv_c_refresh=>soft ).
        go_salv_table->display( ).

      CATCH cx_root ##NO_HANDLER ##CATCH_ALL.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl_events=>get_data( ).
  lcl_events=>build_gui( ).