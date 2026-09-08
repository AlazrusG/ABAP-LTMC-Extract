*&---------------------------------------------------------------------*
*& Report  ZFI_AR_LTMC_EXTRACT
*&---------------------------------------------------------------------*
*&  Extract FI AR open item data and display in single ALV grid
*&---------------------------------------------------------------------*

REPORT zfi_ar_ltmc_extract.

TABLES: bsid, bkpf, bseg, bsec, bset, lfa1.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
SELECT-OPTIONS:
  s_bukrs FOR bsid-bukrs,
  s_xblnr FOR bsid-xblnr,
  s_kunnr FOR bsid-kunnr,

  s_blart FOR bkpf-blart,
  s_bldat FOR bkpf-bldat.
SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE text-003.
SELECT-OPTIONS:
  s_werks FOR bseg-werks,
  s_kostl FOR bseg-kostl,
  s_prctr FOR bseg-prctr.
SELECTION-SCREEN END OF BLOCK b3.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE text-002.
SELECT-OPTIONS:
  s_mkunnr FOR bsid-kunnr.
SELECTION-SCREEN END OF BLOCK b4.

TYPES:

  BEGIN OF ty_customer_open_item_output,
    bukrs              TYPE bsid-bukrs,
    xblnr              TYPE bsid-xblnr,
    docln              TYPE bsid-belnr,
    kunnr              TYPE char13,
    gl_account         TYPE bseg-hkont,
    gkont              TYPE bseg-hkont, "GKONT Offsetting
    blart              TYPE bkpf-blart,
    umskz              TYPE bseg-umskz,
    bldat              TYPE bkpf-bldat,
    wwert              TYPE bkpf-bldat, "Translation date
    bktxt              TYPE bkpf-bktxt,
    sgtxt              TYPE bseg-sgtxt,
    waers              TYPE bkpf-waers,
    wrbtr              TYPE bseg-wrbtr,
    hwaer              TYPE t001-waers,
    dmbtr              TYPE bseg-dmbtr,
    hwae2              TYPE c LENGTH 5,
    dmbe2              TYPE bseg-dmbe2,
    hwae3              TYPE c LENGTH 5,
    dmbe3              TYPE bseg-dmbe3,
    mwskz              TYPE bseg-mwskz,
    bupla              TYPE bseg-bupla,
    sectioncode        TYPE c LENGTH 10,
    vatdate            TYPE bkpf-vatdate, "validation date
    tax_calc_date      TYPE c LENGTH 8,
    xegdr              TYPE bseg-xegdr,
    stceg              TYPE bseg-stceg,
    zterm              TYPE bseg-zterm,
    zfbdt              TYPE bseg-zfbdt,
    zlsch              TYPE bseg-zlsch,
    zlspr              TYPE bseg-zlspr,
    mschl              TYPE bseg-mschl,
    mansp              TYPE bseg-mansp,
    kidno              TYPE bseg-kidno,
    zbd1t              TYPE bseg-zbd1t,
    zbd1p              TYPE bseg-zbd1p,
    zbd2t              TYPE bseg-zbd2t,
    zbd2p              TYPE bseg-zbd2p,
    zbd3t              TYPE bseg-zbd3t,
    skfbt              TYPE bseg-skfbt,
    acskt              TYPE skat-txt20,
    hbkid              TYPE bseg-hbkid,
    hktid              TYPE bseg-hktid,
    bvtyp              TYPE bseg-bvtyp,
    dp_payment_type    TYPE c LENGTH 80, "dptyp?
    dp_trans_id        TYPE c LENGTH 44, "dptid?
    kkber              TYPE bseg-kkber,
    lzbkz              TYPE bseg-lzbkz,
    landl              TYPE bseg-landl,
    xref1              TYPE bseg-xref1,
    xref2              TYPE bseg-xref2,
    xref3              TYPE bseg-xref3,
    prctr              TYPE bseg-prctr,
    fkber              TYPE bseg-fkber,
    kostl              TYPE bseg-kostl,
    pspnr              TYPE bsid-projk, "ps_psp_pnr,
    jv_bilind          TYPE c LENGTH 80,
    joint_venture      TYPE c LENGTH 20,
    recovery_ind       TYPE c LENGTH 3,
    equity_group       TYPE c LENGTH 10,
    material_long      TYPE c LENGTH 40,
    zuonr              TYPE bseg-zuonr,
    part_businessplace TYPE c LENGTH 10,

  END OF ty_customer_open_item_output,

  BEGIN OF ty_customer_open_item_ext,
    bukrs      TYPE bsid-bukrs,
    belnr      TYPE bsid-belnr,
    gjahr      TYPE bsid-gjahr,
    buzei      TYPE bseg-buzei,
    xblnr      TYPE bsid-xblnr,
    kunnr      TYPE char13,
    werks      TYPE bseg-werks,
    projk      TYPE bsid-projk,
    gl_account TYPE bseg-hkont,
    gkont      TYPE bseg-hkont, "GKONT Offsetting
    blart      TYPE bkpf-blart,
    umskz      TYPE bseg-umskz,
    bldat      TYPE bkpf-bldat,
    wwert      TYPE bkpf-bldat,
    bktxt      TYPE bkpf-bktxt,
    sgtxt      TYPE bseg-sgtxt,
    waers      TYPE bkpf-waers,
    wrbtr      TYPE bseg-wrbtr,
    hwaer      TYPE t001-waers,
    dmbtr      TYPE bseg-dmbtr,
    dmbe2      TYPE bseg-dmbe2,
    dmbe3      TYPE bseg-dmbe3,
    mwskz      TYPE bseg-mwskz,
    bupla      TYPE bseg-bupla,
    vatdate    TYPE bkpf-vatdate,
    xegdr      TYPE bseg-xegdr,
    stceg      TYPE bseg-stceg,
    zterm      TYPE bseg-zterm,
    zfbdt      TYPE bseg-zfbdt,
    zlsch      TYPE bseg-zlsch,
    zlspr      TYPE bseg-zlspr,
    mschl      TYPE bseg-mschl,
    mansp      TYPE bseg-mansp,
    kidno      TYPE bseg-kidno,
    zbd1t      TYPE bseg-zbd1t,
    zbd1p      TYPE bseg-zbd1p,
    zbd2t      TYPE bseg-zbd2t,
    zbd2p      TYPE bseg-zbd2p,
    zbd3t      TYPE bseg-zbd3t,
    skfbt      TYPE bseg-skfbt,
    acskt      TYPE skat-txt20,
    hbkid      TYPE bseg-hbkid,
    hktid      TYPE bseg-hktid,
    bvtyp      TYPE bseg-bvtyp,
    kkber      TYPE bseg-kkber,
    lzbkz      TYPE bseg-lzbkz,
    landl      TYPE bseg-landl,
    xref1      TYPE bseg-xref1,
    xref2      TYPE bseg-xref2,
    xref3      TYPE bseg-xref3,
    prctr      TYPE bseg-prctr,
    fkber      TYPE bseg-fkber,
    kostl      TYPE bseg-kostl,
    zuonr      TYPE bseg-zuonr,
  END OF ty_customer_open_item_ext,

  BEGIN OF ty_one_time_account_data,
    bukrs TYPE bsid-bukrs,
    xblnr TYPE bsid-xblnr,
    docln TYPE bsid-belnr,
    kunnr TYPE char13,
    anred TYPE bsec-anred,
    name1 TYPE bsec-name1,
    name2 TYPE bsec-name2,
    name3 TYPE bsec-name3,
    name4 TYPE bsec-name4,
    stras TYPE bsec-stras,
    pstlz TYPE bsec-pstlz,
    ort01 TYPE bsec-ort01,
    regio TYPE bsec-regio,
    land1 TYPE bsec-land1,
    pfach TYPE bsec-pfach,
    pstl2 TYPE bsec-pstl2,
    swift TYPE c LENGTH 11,
    iban  TYPE tiban-iban,
    pskto TYPE bsec-pskto,
    bankn TYPE bsec-bankn,
    bankl TYPE bsec-bankl,
    banks TYPE bsec-banks,
    bkont TYPE bsec-bkont,
    stkza TYPE bsec-stkza,
    dtaws TYPE bsec-dtaws,
    stcd1 TYPE bsec-stcd1,
    stcd2 TYPE bsec-stcd2,
    stcd3 TYPE bsec-stcd3,
    stcd4 TYPE bsec-stcd4,
    stcd5 TYPE c LENGTH 60,
    stkzu TYPE bsec-stkzu,
  END OF ty_one_time_account_data,

  BEGIN OF ty_deffered_tax_items,
    bukrs  TYPE bsid-bukrs,
    xblnr  TYPE bsid-xblnr,
    docln  TYPE bsid-belnr,
    kunnr  TYPE char13,
    buzei  TYPE bsid-buzei,
    hkont  TYPE bset-hkont,
    gkont2 TYPE bset-hkont,
    mwskz  TYPE bset-mwskz,
    txjcd  TYPE bset-txjcd,
    fwbas  TYPE bset-fwbas,
    fwste  TYPE bset-fwste,
    hwbas  TYPE bset-hwbas,
    hwste  TYPE bset-hwste,
    h2bas  TYPE bset-h2bas,
    h2ste  TYPE bset-h2ste,
    h3bas  TYPE bset-h3bas,
    h3ste  TYPE bset-h3ste,
  END OF ty_deffered_tax_items,

  BEGIN OF ty_withholding_tax_items,
    bukrs      TYPE bsid-bukrs,
    xblnr      TYPE bsid-xblnr,
    docln      TYPE bsid-belnr,
    kunnr      TYPE char13,
    wt_type    TYPE with_item-witht,       "FI_WT_READ_WT_INFO
    wt_code    TYPE with_item-wt_withcd,
    "TC
    bas_amt_tc TYPE with_item-wt_qsshb,
    man_amt_tc TYPE with_item-wt_qsshhc,
    awh_amt_tc TYPE with_item-wt_wwrbtr,
    "LC
    bas_amt_lc TYPE with_item-wt_qsshh,
    man_amt_lc TYPE with_item-wt_qbuihh,
    awh_amt_lc TYPE with_item-wt_wdmbtr,
    "L2
    bas_amt_l2 TYPE with_item-wt_qssh2,
    man_amt_l2 TYPE with_item-wt_qbuih2,
    awh_amt_l2 TYPE with_item-wt_wdmbt2,
    "L3
    bas_amt_l3 TYPE with_item-wt_qssh3,
    man_amt_l3 TYPE with_item-wt_qbuih3,
    awh_amt_l3 TYPE with_item-wt_wdmbt3,
  END OF ty_withholding_tax_items,

  BEGIN OF ty_bseg_item,
    bukrs      TYPE bseg-bukrs,
    belnr      TYPE bseg-belnr,
    gjahr      TYPE bseg-gjahr,
    buzei      TYPE bseg-buzei,
    gl_account TYPE bseg-hkont,
    umskz      TYPE bseg-umskz,
    sgtxt      TYPE bseg-sgtxt,
    kidno      TYPE bseg-kidno,
    xref1      TYPE bseg-xref1,
    xref2      TYPE bseg-xref2,
    xref3      TYPE bseg-xref3,
    zuonr      TYPE bseg-zuonr,
    wrbtr      TYPE bseg-wrbtr,
    dmbtr      TYPE bseg-dmbtr,
    dmbe2      TYPE bseg-dmbe2,
    dmbe3      TYPE bseg-dmbe3,
    mwskz      TYPE bseg-mwskz,
    bupla      TYPE bseg-bupla,
    zterm      TYPE bseg-zterm,
    zfbdt      TYPE bseg-zfbdt,
    zlsch      TYPE bseg-zlsch,
    zlspr      TYPE bseg-zlspr,
    zbd1t      TYPE bseg-zbd1t,
    zbd1p      TYPE bseg-zbd1p,
    zbd2t      TYPE bseg-zbd2t,
    zbd2p      TYPE bseg-zbd2p,
    zbd3t      TYPE bseg-zbd3t,
    skfbt      TYPE bseg-skfbt,
    hbkid      TYPE bseg-hbkid,
    hktid      TYPE bseg-hktid,
    bvtyp      TYPE bseg-bvtyp,
    dtws1      TYPE bseg-dtws1,
    dtws2      TYPE bseg-dtws2,
    dtws3      TYPE bseg-dtws3,
    dtws4      TYPE bseg-dtws4,
    lzbkz      TYPE bseg-lzbkz,
    landl      TYPE bseg-landl,
    prctr      TYPE bseg-prctr,
    fkber      TYPE bseg-fkber,
    kostl      TYPE bseg-kostl,
    esrnr      TYPE bseg-esrnr,
    esrre      TYPE bseg-esrre,
  END OF ty_bseg_item.

DATA: gt_customer_open_item_out  TYPE STANDARD TABLE OF ty_customer_open_item_output,
      gt_customer_open_item_data TYPE STANDARD TABLE OF ty_customer_open_item_ext,
      gt_one_time_account_data   TYPE STANDARD TABLE OF ty_one_time_account_data,
      gt_deffered_tax_items      TYPE STANDARD TABLE OF ty_deffered_tax_items,
      gt_witholding_tax_items    TYPE STANDARD TABLE OF ty_withholding_tax_items.


DATA: go_salv_table      TYPE REF TO cl_salv_table,
      go_splitter        TYPE REF TO cl_gui_splitter_container,
      go_container_right TYPE REF TO cl_gui_container,
      go_container_left  TYPE REF TO cl_gui_container.

CLASS lcl_events DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS:
      initialization,
      get_data,
      get_customer_open_items,
      get_one_time_account_data,
      get_deffered_tax_items,
      get_withholding_tax_items,
      convert_kunnr,
      display_data
        CHANGING
          pt_data TYPE ANY TABLE,
      build_gui,
      on_clicked FOR EVENT function_selected OF cl_gui_toolbar
        IMPORTING
            fcode ##NEEDED
        .
ENDCLASS.

CLASS lcl_events IMPLEMENTATION.

  METHOD initialization.

    DATA(lv_current_program) = cl_abap_syst=>get_current_program( ).

    " Restrict Range for converting ECC to S/4 values
    DATA: gs_restrict TYPE sscr_restrict.
    DATA: gt_selopt TYPE TABLE OF rsldbselop.

    DATA: gt_assignment TYPE TABLE OF sscr_ass_tab,
          gt_opt_list   TYPE TABLE OF sscr_opt_list_tab.

    DATA gt_select_fields TYPE STANDARD TABLE OF rsrestrict-objectname
          WITH EMPTY KEY.
    " Mapping fields for our select-options
    gt_select_fields = VALUE #(
      ( 'S_MKUNNR' ) ).

    APPEND INITIAL LINE TO gs_restrict-opt_list_tab
    ASSIGNING FIELD-SYMBOL(<fs_opt_list>).
    <fs_opt_list>-name = 'MAPPING'.
    <fs_opt_list>-options-bt = abap_true.

    LOOP AT gt_select_fields INTO DATA(gv_select_field).
      APPEND INITIAL LINE TO gs_restrict-ass_tab
      ASSIGNING FIELD-SYMBOL(<fs_assignment>).
      <fs_assignment>-kind = 'S'.
      <fs_assignment>-name = gv_select_field.
      <fs_assignment>-sg_main = 'I'.
      <fs_assignment>-sg_addy = space.
      <fs_assignment>-op_main = 'MAPPING'.

      APPEND INITIAL LINE TO gt_selopt
      ASSIGNING FIELD-SYMBOL(<fs_selopt>).
      <fs_selopt>-name = gv_select_field.
    ENDLOOP.

    CALL FUNCTION 'RS_SELOPT_NO_INTERVAL_CHECK'
      EXPORTING
        program = lv_current_program
      TABLES
        selop   = gt_selopt.

    CALL FUNCTION 'SELECT_OPTIONS_RESTRICT'
      EXPORTING
        restriction = gs_restrict.

    " End of range restriction.

  ENDMETHOD.

  METHOD get_data.

    get_customer_open_items( ).
    get_one_time_account_data( ).
    get_deffered_tax_items( ).
    get_withholding_tax_items( ).

  ENDMETHOD.

  METHOD get_customer_open_items.
    DATA lt_bseg TYPE HASHED TABLE OF ty_bseg_item
       WITH UNIQUE KEY bukrs belnr gjahr buzei.
    DATA lt_skat TYPE TABLE OF skat.

    " Header data: BSID (customer open items) + BKPF + T001
    SELECT
      bsid~bukrs,
      bsid~belnr,
      bsid~gjahr,
      bsid~buzei,
      bsid~xblnr,
      bsid~kunnr,
      bsid~projk,
      bkpf~blart,
      bkpf~vatdate,
      bkpf~bktxt,
      bkpf~bldat,
      bkpf~bldat  AS wwert,
      bkpf~waers,
      t001~waers  AS hwaer
      FROM bsid
      INNER JOIN bkpf
        ON bkpf~bukrs = bsid~bukrs
       AND bkpf~belnr = bsid~belnr
       AND bkpf~gjahr = bsid~gjahr
      INNER JOIN t001
        ON t001~bukrs = bsid~bukrs
      INTO CORRESPONDING FIELDS OF TABLE @gt_customer_open_item_data
      WHERE bsid~bukrs IN @s_bukrs
        AND bsid~xblnr IN @s_xblnr
        AND bsid~kunnr IN @s_kunnr
        AND bkpf~blart IN @s_blart
        AND bkpf~bldat IN @s_bldat
        AND EXISTS ( SELECT belnr
				  FROM bseg
				  WHERE bseg~bukrs = bsid~bukrs
					AND bseg~belnr = bsid~belnr
					AND bseg~gjahr = bsid~gjahr
					AND bseg~werks IN @s_werks
					AND bseg~kostl IN @s_kostl
					AND bseg~prctr IN @s_prctr
					).

    CHECK gt_customer_open_item_data IS NOT INITIAL.

    SORT gt_customer_open_item_data BY bukrs belnr gjahr buzei.
    DELETE ADJACENT DUPLICATES
      FROM gt_customer_open_item_data
      COMPARING bukrs belnr gjahr buzei.

    " Line-item detail from BSEG
    SELECT
      bukrs, belnr, gjahr, buzei,
      hkont        AS gl_account,
      umskz,
      sgtxt,
      kidno,
      xref1,
      xref2,
      xref3,
      zuonr,
      wrbtr,
      dmbtr,
      dmbe2,
      dmbe3,
      mwskz,
      bupla,
      zterm,
      zfbdt,
      zlsch,
      zlspr,
      zbd1t,
      zbd1p,
      zbd2t,
      zbd2p,
      skfbt,
      hbkid,
      hktid,
      bvtyp,
      lzbkz,
      landl,
      fkber,
      prctr,
      werks,
      kostl
      FROM bseg
      INTO CORRESPONDING FIELDS OF TABLE @lt_bseg
      FOR ALL ENTRIES IN @gt_customer_open_item_data
      WHERE bukrs = @gt_customer_open_item_data-bukrs
        AND belnr = @gt_customer_open_item_data-belnr
        AND gjahr = @gt_customer_open_item_data-gjahr
        AND buzei = @gt_customer_open_item_data-buzei.

    "Read fields from bseg
    LOOP AT gt_customer_open_item_data ASSIGNING FIELD-SYMBOL(<fs_out_bseg>).
      READ TABLE lt_bseg INTO DATA(ls_bseg)
        WITH TABLE KEY bukrs = <fs_out_bseg>-bukrs
                       belnr = <fs_out_bseg>-belnr
                       gjahr = <fs_out_bseg>-gjahr
                       buzei = <fs_out_bseg>-buzei.
      IF sy-subrc = 0.
        MOVE-CORRESPONDING ls_bseg TO <fs_out_bseg>.
      ENDIF.
    ENDLOOP.

    "Get texts
    SELECT saknr, txt20
      FROM skat
      INTO CORRESPONDING FIELDS OF TABLE @lt_skat
      FOR ALL ENTRIES IN @gt_customer_open_item_data
      WHERE saknr = @gt_customer_open_item_data-gl_account
        AND spras = @sy-langu.
    SORT lt_skat BY saknr.

    LOOP AT gt_customer_open_item_data ASSIGNING FIELD-SYMBOL(<fs_out>).
      READ TABLE lt_skat INTO DATA(ls_skat)
        WITH KEY saknr = <fs_out>-gl_account
        BINARY SEARCH.
      IF sy-subrc = 0.
        <fs_out>-acskt = ls_skat-txt20.
      ENDIF.
    ENDLOOP.

    "Get Gkont
    LOOP AT gt_customer_open_item_data ASSIGNING <fs_out>.

      CALL FUNCTION 'GET_GKONT'
        EXPORTING
          belnr           = <fs_out>-belnr
          bukrs           = <fs_out>-bukrs
          buzei           = <fs_out>-buzei
          gjahr           = <fs_out>-gjahr
          gknkz           = '3'             " Always display with highest amount
        IMPORTING
          gkont           = <fs_out>-gkont
        EXCEPTIONS
          belnr_not_found = 1
          buzei_not_found = 2
          gknkz_not_found = 3
          OTHERS          = 4.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
    ENDLOOP.

* Customer number conversion for S/4HANA
    convert_kunnr( ).

    " Filter Select Options
*    DELETE gt_customer_open_item_data
*           	 WHERE kostl NOT IN s_kostl OR
*				   prctr NOT IN s_prctr.

    CLEAR gt_customer_open_item_out.

    LOOP AT gt_customer_open_item_data ASSIGNING FIELD-SYMBOL(<fs_ext>).
      DATA(ls_cust_out) = VALUE ty_customer_open_item_output( ).
      MOVE-CORRESPONDING <fs_ext> TO ls_cust_out.
      " belnr in the source becomes docln in the output
      ls_cust_out-docln = <fs_ext>-belnr.
      " map project key
      ls_cust_out-pspnr = <fs_ext>-projk.
      " gkont is required field
      IF ls_cust_out-gkont IS INITIAL.
        CONTINUE.
      ENDIF.
      APPEND ls_cust_out TO gt_customer_open_item_out.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_one_time_account_data.

    CHECK gt_customer_open_item_data IS NOT INITIAL.

    SELECT
      bukrs,
      belnr,
      gjahr,
      buzei,
      anred ,
      name1 ,
      name2 ,
      name3 ,
      name4 ,
      stras ,
      pstlz ,
      ort01 ,
      regio ,
      land1 ,
      pfach ,
      pstl2 ,
      pskto ,
      bankl ,
      bankn ,
      banks ,
      bkont ,
      stkza ,
      dtaws ,
      stcd1 ,
      stcd2 ,
      stcd3 ,
      stcd4 ,
      stkzu
      FROM bsec
      INTO TABLE @DATA(lt_bsec)
      FOR ALL ENTRIES IN @gt_customer_open_item_data
      WHERE bukrs = @gt_customer_open_item_data-bukrs
        AND belnr = @gt_customer_open_item_data-belnr
        AND gjahr = @gt_customer_open_item_data-gjahr
        AND buzei = @gt_customer_open_item_data-buzei.

    SORT lt_bsec BY bukrs belnr gjahr buzei.

    LOOP AT gt_customer_open_item_data ASSIGNING FIELD-SYMBOL(<customer>).

      READ TABLE lt_bsec ASSIGNING FIELD-SYMBOL(<fs_bsec>)
        WITH KEY bukrs = <customer>-bukrs
                 belnr = <customer>-belnr
                 gjahr = <customer>-gjahr
                 buzei = <customer>-buzei
        BINARY SEARCH.

      IF sy-subrc = 0
      AND <fs_bsec>-name1 IS NOT INITIAL. " Name1 is required
        APPEND CORRESPONDING #( BASE (
          VALUE #( xblnr = <customer>-xblnr
                   docln = <customer>-belnr
                   kunnr = <customer>-kunnr ) )
          <fs_bsec> ) TO gt_one_time_account_data.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.
  METHOD get_deffered_tax_items.
    CHECK gt_customer_open_item_data IS NOT INITIAL.

    SELECT
      bukrs,
      belnr,
      gjahr,
      buzei,
      hkont,
      mwskz,
      txjcd,
      fwbas,
      fwste,
      hwbas,
      hwste,
      h2bas,
      h2ste,
      h3bas,
      h3ste
      FROM bset
      INTO TABLE @DATA(lt_bset)
      FOR ALL ENTRIES IN @gt_customer_open_item_data
      WHERE bukrs = @gt_customer_open_item_data-bukrs
        AND belnr = @gt_customer_open_item_data-belnr
        AND gjahr = @gt_customer_open_item_data-gjahr.


    SORT lt_bset BY bukrs belnr gjahr.

    LOOP AT lt_bset ASSIGNING FIELD-SYMBOL(<fs_bset>).
*      WHERE hkont IS NOT INITIAL.

      READ TABLE gt_customer_open_item_data
        ASSIGNING FIELD-SYMBOL(<fs_item_data>)
        WITH KEY bukrs = <fs_bset>-bukrs
                 belnr = <fs_bset>-belnr
                 gjahr = <fs_bset>-gjahr
                 BINARY SEARCH.

      IF sy-subrc = 0.
        APPEND CORRESPONDING #( BASE (
          VALUE #( xblnr = <fs_item_data>-xblnr
                   docln = <fs_item_data>-belnr
                   kunnr = <fs_item_data>-kunnr
                   gkont2 = <fs_item_data>-gkont ) )
          <fs_bset> ) TO gt_deffered_tax_items.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
  METHOD get_withholding_tax_items.

    CHECK gt_customer_open_item_data IS NOT INITIAL.


    DATA: lt_with_item     TYPE TABLE OF with_item,
          ls_with_item_out TYPE ty_withholding_tax_items,
          lt_with_item_out TYPE TABLE OF ty_withholding_tax_items.


    LOOP AT gt_customer_open_item_data INTO DATA(ls_open_item).

      CALL FUNCTION 'FI_WT_READ_WT_INFO'
        EXPORTING
          i_bukrs       = ls_open_item-bukrs
          i_belnr       = ls_open_item-belnr
          i_gjahr       = ls_open_item-gjahr
          i_buzei       = ls_open_item-buzei
        TABLES
          t_with_item   = lt_with_item
        EXCEPTIONS
          no_data_found = 1
          OTHERS        = 2.

      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      ls_with_item_out-bukrs = ls_open_item-bukrs.
      ls_with_item_out-xblnr = ls_open_item-xblnr.
      ls_with_item_out-kunnr = ls_open_item-kunnr.
      ls_with_item_out-docln = ls_open_item-belnr.

      LOOP AT lt_with_item INTO DATA(ls_with_item).

        ls_with_item_out-wt_type = ls_with_item-witht.
        ls_with_item_out-wt_code = ls_with_item-wt_withcd.
        ls_with_item_out-bas_amt_tc = ls_with_item-wt_qsshb.
        ls_with_item_out-man_amt_tc = ls_with_item-wt_qsshhc.
        ls_with_item_out-awh_amt_tc = ls_with_item-wt_wwrbtr.
        ls_with_item_out-bas_amt_lc = ls_with_item-wt_qsshh.
        ls_with_item_out-man_amt_lc = ls_with_item-wt_qbuihh.
        ls_with_item_out-awh_amt_lc = ls_with_item-wt_wdmbtr.
        ls_with_item_out-bas_amt_l2 = ls_with_item-wt_qssh2.
        ls_with_item_out-man_amt_l2 = ls_with_item-wt_qbuih2.
        ls_with_item_out-awh_amt_l2 = ls_with_item-wt_wdmbt2.
        ls_with_item_out-bas_amt_l3 = ls_with_item-wt_qssh3.
        ls_with_item_out-man_amt_l3 = ls_with_item-wt_qbuih3.
        ls_with_item_out-awh_amt_l3 = ls_with_item-wt_wdmbt3.

        APPEND ls_with_item_out TO gt_witholding_tax_items.
      ENDLOOP.

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
            ( caption      = 'Customer Open Items'
              icon         = icon_list
              name         = 'CAP1' )
              ( caption      = 'One Time Account Data'
              icon         = icon_list
              name         = 'CAP2' )
              ( caption      = 'Deffered Tax Items'
              icon         = icon_list
              name         = 'CAP3' )
              ( caption      = 'Withholding Tax Items'
              icon         = icon_list
              name         = 'CAP4' ) ).

        DATA:
          lt_event TYPE cntl_simple_events,
          ls_event LIKE LINE OF lt_event.
* Create a cl_gui_container_bar in the left splitter
        DATA(o_toolbar) =
          NEW cl_gui_toolbar(
            parent        = go_container_left " Place in left corner
            display_mode = cl_gui_toolbar=>m_mode_vertical
            name = '1'
             ).   " Tool bar entries
        DATA lv_fcode TYPE ui_func.
        LOOP AT it_captions INTO DATA(is_captions).
          lv_fcode = sy-tabix.
          o_toolbar->add_button(
            fcode = lv_fcode
            icon = is_captions-icon
            text = is_captions-caption
            butn_type = 0
          ).
        ENDLOOP.

        ls_event-eventid = cl_gui_toolbar=>m_id_function_selected.
        ls_event-appl_event = '' .
        APPEND ls_event TO lt_event.

        o_toolbar->set_registered_events( events = lt_event ).

* Register an event handler
        SET HANDLER lcl_events=>on_clicked FOR o_toolbar.

* Display sample data in the right-hand pane
        display_data( CHANGING pt_data = gt_customer_open_item_out ).

* Hide the empty default toolbar
        cl_abap_list_layout=>suppress_toolbar( ).

* Force the display of cl_gui_container=>default_screen
        WRITE: space.

      CATCH cx_root ##NO_HANDLER ##CATCH_ALL.
    ENDTRY.
  ENDMETHOD.

  METHOD on_clicked.

    CASE fcode.
      WHEN 1. " display header data
        lcl_events=>display_data( CHANGING pt_data = gt_customer_open_item_out ).
      WHEN 2. " display header conditions
        lcl_events=>display_data( CHANGING pt_data = gt_one_time_account_data ).
      WHEN 3. " display header texts
        lcl_events=>display_data( CHANGING pt_data = gt_deffered_tax_items ).
      WHEN 4. " display item data
        lcl_events=>display_data( CHANGING pt_data = gt_witholding_tax_items ).
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

  METHOD display_data.
    " generic method to display data in the right-hand pane

    DATA:
      lt_key_fields       TYPE STANDARD TABLE OF lvc_fname WITH EMPTY KEY,
      lt_highlight_fields TYPE STANDARD TABLE OF lvc_fname WITH EMPTY KEY.

    TRY.
        lt_highlight_fields = VALUE #(
          ( 'NAME1' )
          ( 'BLDAT' )
          ( 'HKONT' )
          ( 'GKONT' )
          ( 'GKONT2' )
          ( 'MWSKZ' )
          ( 'ORT01' )
          ( 'WT_TYPE' )
          ( 'BLART' )
          ( 'BUZEI' )
           ).


        lt_key_fields = VALUE #(
          ( 'BUKRS' )
          ( 'XBLNR' )
          ( 'DOCLN' )
          ( 'KUNNR' )
          ).

        IF go_salv_table IS NOT BOUND.
          cl_salv_table=>factory( EXPORTING
                                    r_container    = go_container_right
                                  IMPORTING
                                    r_salv_table   = go_salv_table
                                  CHANGING
                                    t_table        = gt_customer_open_item_out ).
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
        TRY.
            lo_col ?= lo_columns->get_column( 'KUNNR' ).
            lo_col->set_edit_mask( '' ).
            lo_col->set_short_text( 'Customer' ).
            lo_col->set_medium_text( 'Customer' ).
            lo_col->set_long_text( 'Customer' ).
          CATCH cx_salv_not_found.
        ENDTRY.
        go_salv_table->refresh( refresh_mode = if_salv_c_refresh=>soft ).
        go_salv_table->display( ).

      CATCH cx_root ##NO_HANDLER ##CATCH_ALL.
    ENDTRY.

  ENDMETHOD.

  METHOD convert_kunnr.

    TYPES: BEGIN OF ty_kunnr_line,
             low  TYPE vbpa-kunnr,
             high TYPE c LENGTH 10,
           END OF ty_kunnr_line.

    DATA: lt_kunnr_map  TYPE HASHED TABLE OF ty_kunnr_line
                        WITH UNIQUE KEY low,
          ls_kunnr_line LIKE LINE OF         lt_kunnr_map.

    FIELD-SYMBOLS: <fs_open_item> TYPE ty_customer_open_item_ext.
    LOOP AT gt_customer_open_item_data ASSIGNING <fs_open_item>
      WHERE kunnr IS NOT INITIAL.
      " Convert Internal to External Value - ECC
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
        EXPORTING
          input  = <fs_open_item>-kunnr
        IMPORTING
          output = <fs_open_item>-kunnr.
    ENDLOOP.

    CHECK s_mkunnr[] IS NOT INITIAL.

    LOOP AT s_mkunnr[] INTO DATA(ls_kunnr).
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
        EXPORTING
          input  = ls_kunnr-low
        IMPORTING
          output = ls_kunnr_line-low.
      ls_kunnr_line-high = ls_kunnr-high.
      INSERT ls_kunnr_line INTO TABLE lt_kunnr_map.
    ENDLOOP.

    LOOP AT gt_customer_open_item_data ASSIGNING <fs_open_item>
      WHERE kunnr IS NOT INITIAL.
      .
      READ TABLE lt_kunnr_map
        WITH TABLE KEY low = <fs_open_item>-kunnr
        INTO ls_kunnr_line.
      IF sy-subrc = 0.
        <fs_open_item>-kunnr = ls_kunnr_line-high.
      ELSE.
        WRITE <fs_open_item>-kunnr
          TO <fs_open_item>-kunnr.
        "Indicate this value has not been mapped to S/4
        CONCATENATE <fs_open_item>-kunnr '-NC'
          INTO <fs_open_item>-kunnr.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

INITIALIZATION.
  lcl_events=>initialization( ).

START-OF-SELECTION.
  lcl_events=>get_data( ).
  lcl_events=>build_gui( ).