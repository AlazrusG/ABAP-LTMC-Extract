*&---------------------------------------------------------------------*
*& Report  ZMM_OPENPO_EXTRACT
*&---------------------------------------------------------------------*
*& Extract OPEN PO data and display it in a ALV
*&---------------------------------------------------------------------*

REPORT zmm_openpo_extract.

TABLES: ekko, ekpo.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
SELECT-OPTIONS:
  s_ebeln FOR ekko-ebeln,
  s_bukrs FOR ekko-bukrs,
  s_bstyp FOR ekko-bstyp,
  s_bsart FOR ekko-bsart,
  s_aedat FOR ekko-aedat,
  s_lifnr FOR ekko-lifnr,
  s_reswk FOR ekko-reswk,
  s_ekorg FOR ekko-ekorg,
  s_ekgrp FOR ekko-ekgrp.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
SELECT-OPTIONS:
  s_matnr FOR ekpo-matnr,
  s_werks FOR ekpo-werks,
  s_lgort FOR ekpo-lgort,
  s_knttp FOR ekpo-knttp,
  s_matkl FOR ekpo-matkl.
SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF BLOCK b1.

TYPES:
  BEGIN OF ty_header_data,
    ebeln   TYPE ekko-ebeln,
    bukrs   TYPE ekko-bukrs,
    bsart   TYPE ekko-bsart,
    lifnr   TYPE ekko-lifnr,
    ekorg   TYPE ekko-ekorg,
    ekgrp   TYPE ekko-ekgrp,
    bedat   TYPE ekko-bedat,
    zterm   TYPE ekko-zterm,
    zbd1t   TYPE ekko-zbd1t,
    zbd2t   TYPE ekko-zbd2t,
    zbd3t   TYPE ekko-zbd3t,
    zbd1p   TYPE ekko-zbd1p,
    zbd2p   TYPE ekko-zbd2p,
    waers   TYPE ekko-waers,
    " Keep raw sign in ALV by avoiding EXCRT conversion exit from DDIC type EKKO-WKURS
    wkurs   TYPE p LENGTH 8 DECIMALS 5,
    lifre   TYPE ekko-lifre,
    incov   TYPE ekko-incov,
    inco1   TYPE ekko-inco1,
    inco2_l TYPE ekko-inco2_l,
    inco3_l TYPE ekko-inco3_l,
    verkf   TYPE ekko-verkf,
    telf1   TYPE ekko-telf1,
    ihrez   TYPE ekko-ihrez,
    unsez   TYPE ekko-unsez,
    stceg_l TYPE ekko-stceg_l,
  END OF ty_header_data,

  BEGIN OF ty_header_address,
    ebeln      TYPE ekko-ebeln,
    city1      TYPE adrc-city1,
    post_code1 TYPE adrc-post_code1,
    street     TYPE adrc-street,
    house_num1 TYPE adrc-house_num1,
    country    TYPE adrc-country,
    region     TYPE adrc-region,
    tel_number TYPE adrc-tel_number,
    fax_number TYPE adrc-fax_number,
    name1      TYPE adrc-name1,
  END OF ty_header_address,

  BEGIN OF ty_header_text,
    ebeln      TYPE ekko-ebeln,
    tdid       TYPE rstxt-tdid,
    text_lines TYPE string,
  END OF ty_header_text,

  BEGIN OF ty_item_data,
    ebeln            TYPE ekpo-ebeln,
    ebelp            TYPE ekpo-ebelp,
    pstyp            TYPE ekpo-pstyp,
    knttp            TYPE ekpo-knttp,
    matnr            TYPE ekpo-matnr,
    txz01            TYPE ekpo-txz01,
    werks            TYPE ekpo-werks,
    lgort            TYPE ekpo-lgort,
    charg            TYPE eket-charg,
    licha            TYPE eket-licha,
    matkl            TYPE ekpo-matkl,
    producttype      TYPE char10, "optional field s4
    afnam            TYPE ekpo-afnam,
    idnlf            TYPE ekpo-idnlf,
    menge            TYPE ekpo-menge,
    meins            TYPE ekpo-meins,
    bprme            TYPE ekpo-bprme,
    bpumz            TYPE ekpo-bpumz,
    bpumn            TYPE ekpo-bpumn,
    ldate            TYPE eket-eindt,
    netpr            TYPE ekpo-netpr,
    peinh            TYPE ekpo-peinh,
    bstae            TYPE ekpo-bstae,
    mwskz            TYPE ekpo-mwskz,
    txjcd            TYPE ekpo-txjcd,
    uebto            TYPE ekpo-uebto,
    uebtk            TYPE ekpo-uebtk,
    untto            TYPE ekpo-untto,
    evers            TYPE ekpo-evers,
    mahn1            TYPE ekpo-mahn1,
    mahn2            TYPE ekpo-mahn2,
    mahn3            TYPE ekpo-mahn3,
    plifz            TYPE ekpo-plifz,
    bwtar            TYPE ekpo-bwtar,
    elikz            TYPE ekpo-elikz,
    erekz            TYPE ekpo-erekz,
    wepos            TYPE ekpo-wepos,
    weunb            TYPE ekpo-weunb,
    repos            TYPE ekpo-repos,
    webre            TYPE ekpo-webre,
    retpo            TYPE ekpo-retpo,
    vrtkz            TYPE ekpo-vrtkz,
    twrkz            TYPE ekpo-twrkz,
    inco1            TYPE ekpo-inco1,
    inco2_l          TYPE ekpo-inco2_l,
    inco3_l          TYPE ekpo-inco3_l,
    exp_value        TYPE char10,
    limit_amount     TYPE char10,
    emlif            TYPE ekpo-emlif,
    lblkz            TYPE ekpo-lblkz,
    kunnr            TYPE ekpo-kunnr,
    konnr            TYPE ekpo-konnr,
    ktpnr            TYPE ekpo-ktpnr,
    serviceperformer TYPE char10,
    startdate        TYPE char10,
    enddate          TYPE char10,
  END OF ty_item_data,

  BEGIN OF ty_item_address,
    ebeln      TYPE ekko-ebeln,
    ebelp      TYPE ekpo-ebelp,
    city1      TYPE adrc-city1,
    post_code1 TYPE adrc-post_code1,
    street     TYPE adrc-street,
    house_num1 TYPE adrc-house_num1,
    country    TYPE adrc-country,
    region     TYPE adrc-region,
    tel_number TYPE adrc-tel_number,
    fax_number TYPE adrc-fax_number,
    name1      TYPE adrc-name1,
  END OF ty_item_address,

  BEGIN OF ty_account_assignment,
    ebeln      TYPE ekkn-ebeln,
    ebelp      TYPE ekkn-ebelp,
    zekkn      TYPE ekkn-zekkn,
    menge      TYPE ekkn-menge,
    vproz      TYPE ekkn-vproz,
    netwr      TYPE ekkn-netwr,
    sakto      TYPE ekkn-sakto,
    kostl      TYPE ekkn-kostl,
    prctr      TYPE ekkn-prctr,
    aufnr      TYPE ekkn-aufnr,
    WBS_ELEMENT TYPE ekkn-ps_psp_pnr,
    vbeln      TYPE ekkn-vbeln,
    vbelp      TYPE ekkn-vbelp,
    ETENR      TYPE ekkn-veten,
    ASSET_NO      TYPE ekkn-anln1,
    SUB_NUMBER      TYPE ekkn-anln2,
    fkber      TYPE ekkn-fkber,
  END OF ty_account_assignment,

  BEGIN OF ty_schedule_line,
    ebeln TYPE eket-ebeln,
    ebelp TYPE eket-ebelp,
    etenr TYPE eket-etenr,
    eindt TYPE eket-eindt,
    menge TYPE eket-menge,
  END OF ty_schedule_line,

  BEGIN OF ty_subcontracting,
    ebeln TYPE ekko-ebeln,
    ebelp TYPE ekpo-ebelp,
    etenr TYPE eket-etenr,
    ebele TYPE resb-ebele,
    matnr TYPE resb-matnr,
    werks TYPE resb-werks,
    lgort TYPE resb-lgort,
    bdmng TYPE resb-bdmng,
    meins TYPE resb-meins,
    bdter TYPE resb-bdter,
  END OF ty_subcontracting,

  BEGIN OF ty_item_text,
    ebeln      TYPE ekko-ebeln,
    ebelp      TYPE ekpo-ebelp,
    tdid       TYPE rstxt-tdid,
    text_lines TYPE string,
  END OF ty_item_text,

  BEGIN OF ty_adrc_lookup,
           addrnumber TYPE adrc-addrnumber,
           city1      TYPE adrc-city1,
           post_code1 TYPE adrc-post_code1,
           street     TYPE adrc-street,
           house_num1 TYPE adrc-house_num1,
           country    TYPE adrc-country,
           region     TYPE adrc-region,
           tel_number TYPE adrc-tel_number,
           fax_number TYPE adrc-fax_number,
           name1      TYPE adrc-name1,
   END OF ty_adrc_lookup.

DATA:
  gt_ekko               TYPE TABLE OF ekko,
  gt_ekpo               TYPE TABLE OF ekpo,
  gt_eket               TYPE TABLE OF eket,

  gt_header_data        TYPE TABLE OF ty_header_data,
  gt_header_address     TYPE TABLE OF ty_header_address,
  gt_header_texts       TYPE TABLE OF ty_header_text,
  gt_item_data          TYPE TABLE OF ty_item_data,
  gt_item_address       TYPE TABLE OF ty_item_address,
  gt_account_assignment TYPE TABLE OF ty_account_assignment,
  gt_item_texts         TYPE TABLE OF ty_item_text,
  gt_schedule_line      TYPE TABLE OF ty_schedule_line,
  gt_subcontracting     TYPE TABLE OF ty_subcontracting.


* Each entry for the cl_gui_container_bar is a single button

DATA: go_salv_table      TYPE REF TO cl_salv_table,
      go_splitter        TYPE REF TO cl_gui_splitter_container,
      go_container_right TYPE REF TO cl_gui_container,
      go_container_left  TYPE REF TO cl_gui_container.

CLASS lcl_events DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      get_data,
      get_header_data,
      get_header_address,
      get_header_texts,
      get_item_data,
      get_item_address,
      get_account_assignment,
      get_schedule_line,
      get_subcontracting,
      get_item_texts,
      build_gui,
      display_data
        CHANGING
          pt_data TYPE ANY TABLE,
      on_clicked FOR EVENT clicked OF cl_gui_container_bar_2
        IMPORTING
            id
            container ##NEEDED
            sender ##NEEDED
        .
ENDCLASS.

CLASS lcl_events IMPLEMENTATION.

  METHOD get_data.

    " assume open PO delivery not complete and not deleted
    " SAP in ME2N Defines OPEN PO as delivery not complete, deleted and not fully invoiced,
    SELECT *
     FROM ekpo
     INTO CORRESPONDING FIELDS OF TABLE gt_ekpo
     WHERE ebeln IN s_ebeln AND
           bukrs IN s_bukrs AND
           matnr IN s_matnr AND
           werks IN s_werks AND
           lgort IN s_lgort AND
           knttp IN s_knttp AND
           matkl IN s_matkl AND
           elikz EQ space AND  " delivery completed indicator
           loekz EQ space AND "deletion flag
           EXISTS ( SELECT * FROM ekko
                    WHERE ebeln = ekpo~ebeln AND
                          bstyp IN s_bstyp AND
                          bsart IN s_bsart AND
                          aedat IN s_aedat AND
                          lifnr IN s_lifnr AND
                          reswk IN s_reswk AND
                          ekorg IN s_ekorg AND
                          ekgrp IN s_ekgrp ) AND
           NOT EXISTS ( SELECT * FROM ekbe
                        WHERE ebeln = ekpo~ebeln AND
                              ebelp = ekpo~ebelp AND
                              bwart = '101' ).

    IF gt_ekpo IS INITIAL.
      MESSAGE 'No open PO items found' TYPE 'I'.
      RETURN.
    ENDIF.

    get_header_data( ).
    get_header_address( ).
    get_header_texts( ).
    get_item_data( ).
    get_item_address( ).
    get_account_assignment( ).
    get_schedule_line( ).
    get_subcontracting( ).
    get_item_texts( ).

  ENDMETHOD.
  METHOD get_header_data.

    CHECK gt_ekpo IS NOT INITIAL.

    SELECT *
      FROM ekko
      INTO CORRESPONDING FIELDS OF TABLE gt_ekko
      FOR ALL ENTRIES IN gt_ekpo
      WHERE ebeln = gt_ekpo-ebeln.

    LOOP AT gt_ekko INTO DATA(ls_ekko).
      APPEND INITIAL LINE TO gt_header_data
       ASSIGNING FIELD-SYMBOL(<ls_header_data>).
      MOVE-CORRESPONDING ls_ekko TO <ls_header_data>.
    ENDLOOP.

  ENDMETHOD.
  METHOD get_header_address.

    CHECK gt_ekko IS NOT INITIAL.

    DATA lt_ebeln TYPE SORTED TABLE OF ekko-ebeln WITH UNIQUE KEY table_line.
    LOOP AT gt_ekko INTO DATA(ls_ekko).
      APPEND ls_ekko-ebeln TO lt_ebeln.
    ENDLOOP.

    SELECT
        ekko~ebeln
        adrc~city1
        adrc~post_code1
        adrc~street
        adrc~house_num1
        adrc~country
        adrc~region
        adrc~tel_number
        adrc~fax_number
        adrc~name1
      FROM ekko
      INNER JOIN adrc
        ON adrc~addrnumber = ekko~adrnr
      INTO CORRESPONDING FIELDS OF TABLE gt_header_address
      FOR ALL ENTRIES IN lt_ebeln
      WHERE ekko~ebeln = lt_ebeln-table_line.

  ENDMETHOD.

  METHOD get_header_texts.

    CHECK gt_ekko IS NOT INITIAL.

    DATA:
      lt_tdname TYPE TABLE OF stxh-tdname,
      lt_stxh   TYPE TABLE OF stxh,
      ls_header TYPE          thead,
      lt_lines  TYPE TABLE OF tline.

    LOOP AT gt_ekko INTO DATA(ls_ekko).
      APPEND ls_ekko-ebeln TO lt_tdname.
    ENDLOOP.

    SELECT *
      FROM stxh
      INTO CORRESPONDING FIELDS OF TABLE lt_stxh
      FOR ALL ENTRIES IN lt_tdname
      WHERE tdobject = 'EKKO' AND
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

      <ls_header_text>-ebeln = ls_stxh-tdname.
      <ls_header_text>-tdid = ls_stxh-tdid.

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

    CHECK gt_ekpo IS NOT INITIAL.
    LOOP AT gt_ekpo INTO DATA(ls_ekpo).
      APPEND INITIAL LINE TO gt_item_data
       ASSIGNING FIELD-SYMBOL(<ls_item_data>).
      MOVE-CORRESPONDING ls_ekpo TO <ls_item_data>.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_item_address.

    CHECK gt_ekpo IS NOT INITIAL.

    DATA lt_adrnr TYPE TABLE OF ekpo-adrnr WITH KEY table_line.
    LOOP AT gt_ekpo INTO DATA(ls_ekpo) WHERE adrnr IS NOT INITIAL.
      INSERT ls_ekpo-adrnr INTO TABLE lt_adrnr.
    ENDLOOP.

    DATA lt_adrc TYPE TABLE OF ty_adrc_lookup WITH KEY addrnumber.

    SELECT
        adrc~addrnumber,
        adrc~city1,
        adrc~post_code1,
        adrc~street,
        adrc~house_num1,
        adrc~country,
        adrc~region,
        adrc~tel_number,
        adrc~fax_number,
        adrc~name1
      FROM adrc
      INTO TABLE @lt_adrc
      FOR ALL ENTRIES IN @lt_adrnr
      WHERE addrnumber = @lt_adrnr-table_line.

    LOOP AT gt_ekpo INTO ls_ekpo.
      READ TABLE lt_adrc
      INTO DATA(ls_adrc)
      WITH TABLE KEY addrnumber = ls_ekpo-adrnr.
     IF sy-subrc = 0.
          APPEND VALUE ty_item_address(
            ebeln      = ls_ekpo-ebeln
            ebelp      = ls_ekpo-ebelp
            city1      = ls_adrc-city1
            post_code1 = ls_adrc-post_code1
            street     = ls_adrc-street
            house_num1 = ls_adrc-house_num1
            country    = ls_adrc-country
            region     = ls_adrc-region
            tel_number = ls_adrc-tel_number
            fax_number = ls_adrc-fax_number
            name1      = ls_adrc-name1 ) TO gt_item_address.
        ENDIF.
  ENDLOOP.

  ENDMETHOD.

  METHOD get_account_assignment.

    CHECK gt_ekpo IS NOT INITIAL.

    SELECT
    ebeln,
    ebelp,
    zekkn,
    menge,
    vproz,
    netwr,
    sakto,
    kostl,
    prctr,
    aufnr,
    ps_psp_pnr AS wbs_elemnt,
    vbeln,
    vbelp,
    veten AS etenr,
    anln1 AS asset_no,
    anln2 AS sub_number,
    fkber
    FROM ekkn
    INTO CORRESPONDING FIELDS OF TABLE @gt_account_assignment
    FOR ALL ENTRIES IN @gt_ekpo
    WHERE ebeln = @gt_ekpo-ebeln
    AND ebelp = @gt_ekpo-ebelp.

  ENDMETHOD.

  METHOD get_schedule_line.

    CHECK gt_ekpo IS NOT INITIAL.

    SELECT *
    FROM eket
    INTO CORRESPONDING FIELDS OF TABLE gt_eket
    FOR ALL ENTRIES IN gt_ekpo
    WHERE ebeln = gt_ekpo-ebeln
    AND   ebelp = gt_ekpo-ebelp
    ORDER BY PRIMARY KEY.

    "Add schedule line data to item data table
    LOOP AT gt_item_data ASSIGNING FIELD-SYMBOL(<ls_item_data>).
      READ TABLE gt_eket
        INTO DATA(ls_eket)
        WITH KEY ebeln = <ls_item_data>-ebeln
                 ebelp = <ls_item_data>-ebelp
                 BINARY SEARCH.
      IF sy-subrc = 0.
        <ls_item_data>-charg = ls_eket-charg.
        <ls_item_data>-licha = ls_eket-licha.
      ENDIF.
    ENDLOOP.

    LOOP AT gt_eket INTO ls_eket.
      APPEND INITIAL LINE TO gt_schedule_line
       ASSIGNING FIELD-SYMBOL(<ls_schedule_line>).
      MOVE-CORRESPONDING ls_eket TO <ls_schedule_line>.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_subcontracting.

    CHECK gt_eket IS NOT INITIAL.

    SELECT *
    FROM resb
    INNER JOIN eket
    ON eket~rsnum = resb~rsnum
    INTO CORRESPONDING FIELDS OF TABLE gt_subcontracting
    FOR ALL ENTRIES IN gt_eket
    WHERE resb~rsnum = gt_eket-rsnum
    AND resb~bdmng > 0. " only include components with open quantity


  ENDMETHOD.

  METHOD get_item_texts.


    CHECK gt_ekpo IS NOT INITIAL.

    DATA:
      lt_tdname TYPE TABLE OF stxh-tdname,
      lt_stxh   TYPE TABLE OF stxh,
      ls_header TYPE          thead,
      lt_lines  TYPE TABLE OF tline.

    LOOP AT gt_ekpo INTO DATA(ls_ekpo).
      APPEND ls_ekpo-ebeln && ls_ekpo-ebelp TO lt_tdname.
    ENDLOOP.

    SELECT *
      FROM stxh
      INTO CORRESPONDING FIELDS OF TABLE lt_stxh
      FOR ALL ENTRIES IN lt_tdname
      WHERE tdobject = 'EKPO' AND
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

      <ls_item_text>-ebeln = ls_stxh-tdname(10).
      <ls_item_text>-ebelp = ls_stxh-tdname+10(5).
      <ls_item_text>-tdid = ls_stxh-tdid.

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
            ( caption      = 'Address Header'
              icon         = icon_list
              name         = 'CAP2' )
            ( caption      = 'Header Text'
              icon         = icon_list
              name         = 'CAP3' )
            ( caption    = 'Item Data'
              icon         = icon_list
              name         = 'CAP4' )
            ( caption    = 'Item Address'
              icon         = icon_list
              name         = 'CAP5' )
            ( caption    = 'Account Assignment'
              icon         = icon_list
              name         = 'CAP6' )
            ( caption    = 'Schedule Lines'
              icon         = icon_list
              name         = 'CAP7' )
            ( caption    = 'Subcontracting Components'
              icon         = icon_list
              name         = 'CAP8' )
            ( caption    = 'Item Texts'
              icon         = icon_list
              name         = 'CAP9' ) ).

* Create a cl_gui_container_bar in the left splitter
        DATA(o_toolbar) =
          NEW cl_gui_container_bar_2(
            active_id     = 1                " Number of active entry
            parent        = go_container_left " Place in left corner
            captions      = it_captions
            style = cl_gui_container_bar_2=>c_style_tile
            close_buttons = abap_false ).   " Tool bar entries

* Register an event handler
        SET HANDLER lcl_events=>on_clicked FOR o_toolbar.
* Display sample data in the right-hand pane
        display_data( CHANGING pt_data = gt_header_data ).
* Hide the empty default toolbar
        cl_abap_list_layout=>suppress_toolbar( ).
* Force the display of cl_gui_container=>default_screen
        WRITE: space.
      CATCH cx_root INTO DATA(e_txt).
    ENDTRY.
  ENDMETHOD.
  METHOD on_clicked.
*    MESSAGE |Property: { id } { container->get_container_type( ) }| TYPE 'S'.
    CASE id.
      WHEN 1.
        lcl_events=>display_data( CHANGING pt_data = gt_header_data ).
      WHEN 2.
        lcl_events=>display_data( CHANGING pt_data = gt_header_address ).
      WHEN 3.
        lcl_events=>display_data( CHANGING pt_data = gt_header_texts ).
      WHEN 4.
        lcl_events=>display_data( CHANGING pt_data = gt_item_data ).
      WHEN 5.
        lcl_events=>display_data( CHANGING pt_data = gt_item_address ).
      WHEN 6.
        lcl_events=>display_data( CHANGING pt_data = gt_account_assignment ).
      WHEN 7.
        lcl_events=>display_data( CHANGING pt_data = gt_schedule_line ).
      WHEN 8.
        lcl_events=>display_data( CHANGING pt_data = gt_subcontracting ).
      WHEN 9.
        lcl_events=>display_data( CHANGING pt_data = gt_item_texts ).
    ENDCASE.

  ENDMETHOD.

  METHOD display_data.
    " generic method to display data in the right-hand pane

    TRY.
        DATA(ls_yellow) = VALUE lvc_s_colo( col = 3 ).
        DATA lt_highlight_fields TYPE STANDARD TABLE OF lvc_fname WITH EMPTY KEY.
        lt_highlight_fields = VALUE #(
          ( 'BUKRS' )
          ( 'BSART' )
          ( 'LIFNR' )
          ( 'WAERS' )
          ( 'TDID' )
          ( 'TEXT_LINES' )
          ( 'EINDT' )
          ( 'MENGE' )
          ( 'MATNR' )
          ( 'WERKS' )
          ( 'BDMNG' )
          ( 'MEINS' )
          ( 'BDTER' ) ).

        DATA(ls_key) = VALUE lvc_s_colo( col = 3 ).
        DATA lt_key_fields TYPE STANDARD TABLE OF lvc_fname WITH EMPTY KEY.
        lt_key_fields = VALUE #(
          ( 'EBELN' )
          ( 'EKORG' )
          ( 'ETENR' )
          ( 'EBELP' )
          ( 'ZEKKN' )
          ( 'ETENR' )
          ( 'EBELE' ) ).

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
              DATA(lo_col) = CAST cl_salv_column_table( lo_columns->get_column( lv_key_field ) ).
              lo_col->set_key( abap_true ).
            CATCH cx_salv_not_found.
          ENDTRY.
        ENDLOOP.
        " Highlight mandatory fields defined in the migration template
        LOOP AT lt_highlight_fields INTO DATA(lv_highlight_field).
          TRY.
              lo_col = CAST cl_salv_column_table( lo_columns->get_column( lv_highlight_field ) ).
              lo_col->set_color( ls_yellow ).
            CATCH cx_salv_not_found.
          ENDTRY.
        ENDLOOP.
        go_salv_table->refresh( refresh_mode = if_salv_c_refresh=>soft ).
        go_salv_table->display( ).

      CATCH cx_root INTO DATA(e_txt).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl_events=>get_data( ).
  lcl_events=>build_gui( ).