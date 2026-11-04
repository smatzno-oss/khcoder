package gui_window::main::menu;

use strict;
use Tk;

# ¥á¥Ë¥å¡¼¤ÎÀßÄê¡§¥×¥í¥¸¥§¥¯¥È¤¬ÁªÂò¤µ¤ì¤ì¤ĞActive
my @menu0 = (
	'm_b1_mark',
	'm_b2_morpho',
	't_sql_select',
	'm_b0_close',
	'm_b0_editdata',
	#'m_b1_hukugo',
	#'m_b1_hukugo_te',
	#'m_b2_datacheck',
);

# ¥á¥Ë¥å¡¼¤ÎÀßÄê¡§·ÁÂÖÁÇ²òÀÏ¤¬¹Ô¤ï¤ì¤Æ¤¤¤ì¤ĞActive
my @menu1 = (
	't_word_search',
	#'t_word_list',
	't_word_list_cf',
	't_word_freq',
	't_word_df_freq',
	't_word_ass',
	't_word_conc',
	'm_b3_check',
	't_cod_count',
	#'t_cod_tab',
	't_cod_jaccard',
	#'t_cod_multi',
	't_cod_out',
	't_cod_outtab',
	't_cod_out_spss',
	't_cod_out_csv',
	't_cod_out_tab',
	't_cod_out_var',
	't_txt_html2mod',
	'm_b3_crossout',
	'm_b3_crossout_csv',
	'm_b3_crossout_spss',
	'm_b3_crossout_tab',
	'm_b3_crossout_var',
	't_txt_pickup',
	't_doc_search',
	't_out_list',
	'm_b3_contxtout',
	'm_b3_contxtout_spss',
	'm_b3_contxtout_csv',
	'm_b3_contxtout_tab',
	'm_b0_export',
	't_cas_bayes',
	't_bayes_learn',
	't_bayes_predict',
	't_bayes_view',
	't_bayes_view_log',
	't_topic_pp',
	't_topic_ft',

	't_word_list_cf2',
	'm_b3_crossout2',
	'm_b3_crossout_csv2',
	'm_b3_crossout_spss2',
	'm_b3_crossout_tab2',
	'm_b3_crossout_var2',
	't_cod_out2',
	't_cod_out_csv2',
	't_cod_out_spss2',
	't_cod_out_tab2',
	't_cod_out_var2',
	'm_b3_contxtout2',
	'm_b3_contxtout_csv2',
	'm_b3_contxtout_spss2',
	'm_b3_contxtout_tab2',
	't_txt_pickup2',
	't_txt_html2mod2',
	'm_b0_export2',
);


#------------------#
#   ¥á¥Ë¥å¡¼ºîÀ®   #
#------------------#

sub make{
	my $class = shift;
	my $mw    = shift;
	my $self;
	
	#my $menubar = $mw->Menu(-type => 'menubar');
	my $menubar = $mw->Menu();
	$mw->configure(-menu => $menubar);

	#------------------#
	#   ¥×¥í¥¸¥§¥¯¥È   #

	my $msg = gui_window->gui_jm( kh_msg->get('project') );
	my $underline_pos = -1;
	$underline_pos = index($msg, 'P');
	$underline_pos = 0 if $underline_pos == -1;
	my $f1 = $menubar->cascade(
		-label => $msg,
		-font => "TKFN",
		-underline => $underline_pos,
		-tearoff=>'no'
	);

	# ¤³¤³¤ÇMain Window¤ÎÃæ¿È¤òºîÀ®¤·¤Æ¤ª¤¯
	# http://khcoder.info/cgi-bin/bbs_khn/khcf.cgi?no=2699&mode=allread#3107
	$::main_gui->{inner} = 'gui_window::main::inner'->make($::main_gui->{win_obj});

		my $m4a_project = $f1->command(
			-label => kh_msg->get('new'),
			-font => "TKFN",
			-command =>
				sub{gui_window::project_new->open;},
			-accelerator => 'Ctrl+N'
		);
		$f1->command(
			-label => kh_msg->get('open'),
			-font => "TKFN",
			-command =>
				sub{gui_window::project_open->open;},
			-accelerator => 'Ctrl+O'
		);
		$self->{m_b0_close} = $f1->command(
			-label => kh_msg->get('close'),
			-font => "TKFN",
			-state => 'disable',
			-command =>
				sub{
						$self->mc_close_project;
					},
			-accelerator => 'Ctrl+W'
		);
		
		$f1->separator();



		# export menu #1
		my $f_export = $f1->cascade(
				-label => kh_msg->get('export'),
				-font => "TKFN",
				-tearoff=>'no'
			);

		$self->{t_word_list_cf} = $f_export->command(
				-label => kh_msg->get('word_freq'), #gui_window->gui_jchar('Ãê½Ğ¸ì¥ê¥¹¥È'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_list->open;
				},
				-state => 'disable'
			);

		$f_export->separator;
		
		$self->{m_b3_crossout} = $f_export->cascade(
				-label => kh_msg->get('doc_term_mtrx'),#gui_window->gui_jchar("¡ÖÊ¸½ñ£øÃê½Ğ¸ì¡×É½¤Î½ĞÎÏ",'euc'),
				-font => "TKFN",
				-state => 'disable',
				-tearoff=>'no'
			);

			$self->{m_b3_crossout_csv} = $self->{m_b3_crossout}->command(
				-label => kh_msg->gget('csv_f'),#gui_window->gui_jchar("CSV¥Õ¥¡¥¤¥ë"),
				-font  => "TKFN",
				-command => sub{
					gui_window::morpho_crossout::csv->open;
				},
			);

			$self->{m_b3_crossout_spss} = $self->{m_b3_crossout}->command(
				-label => kh_msg->gget('spss_f'),#gui_window->gui_jchar("SPSS¥Õ¥¡¥¤¥ë"),
				-font  => "TKFN",
				-command => sub{
					gui_window::morpho_crossout::spss->open;
				},
			);

			$self->{m_b3_crossout_tab} = $self->{m_b3_crossout}->command(
				-label => kh_msg->gget('tab_f'),#gui_window->gui_jchar("¥¿¥Ö¶èÀÚ¤ê"),
				-font  => "TKFN",
				-command => sub{
					gui_window::morpho_crossout::tab->open;
				},
			);

			$self->{m_b3_crossout}->separator;

			$self->{m_b3_crossout_var} = $self->{m_b3_crossout}->command(
				-label => kh_msg->gget('wm_f'),#gui_window->gui_jchar("ÉÔÄêÄ¹CSV ¡ÊWordMiner¡Ë"),
				-font  => "TKFN",
				-command => sub{
					gui_window::morpho_crossout::var->open;
				},
			);

		$self->{t_cod_out} = $f_export->cascade(
			-label => kh_msg->get('output_cod'),#gui_window->gui_jchar('¥³¡¼¥Ç¥£¥ó¥°·ë²Ì¤Î½ĞÎÏ'),
			 -font => "TKFN",
			 -tearoff=>'no'
		);

			$self->{t_cod_out_csv} = $self->{t_cod_out}->command(
				-label => kh_msg->gget('csv_f'),#gui_window->gui_jchar('CSV¥Õ¥¡¥¤¥ë'),
				-font => "TKFN",
				-command => sub{
						gui_window::cod_out::csv->open;
					},
				-state => 'disable'
			);

			$self->{t_cod_out_spss} = $self->{t_cod_out}->command(
				-label => kh_msg->gget('spss_f'),#gui_window->gui_jchar('SPSS¥Õ¥¡¥¤¥ë'),
				-font => "TKFN",
				-command => sub{
						gui_window::cod_out::spss->open;
					},
				-state => 'disable'
			);

			$self->{t_cod_out_tab} = $self->{t_cod_out}->command(
				-label => kh_msg->gget('tab_f'),#gui_window->gui_jchar('¥¿¥Ö¶èÀÚ¤ê'),
				-font => "TKFN",
				-command => sub{
						gui_window::cod_out::tab->open;
					},
				-state => 'disable'
			);

			$self->{t_cod_out}->separator();

			$self->{t_cod_out_var} = $self->{t_cod_out}->command(
				-label => kh_msg->gget('wm_f'),#gui_window->gui_jchar('ÉÔÄêÄ¹CSV ¡ÊWordMiner¡Ë'),
				-font => "TKFN",
				-command => sub{
						gui_window::cod_out::var->open;
					},
				-state => 'disable'
			);

		$self->{m_b3_contxtout} = $f_export->cascade(
				-label => kh_msg->get('term_vec_mtrx'),#gui_window->gui_jchar("¡ÖÃê½Ğ¸ì£øÊ¸Ì®¥Ù¥¯¥È¥ë¡×É½¤Î½ĞÎÏ",'euc'),
				-font => "TKFN",
				-state => 'disable',
				-tearoff=>'no'
			);

			$self->{m_b3_contxtout_csv} = $self->{m_b3_contxtout}->command(
				-label => kh_msg->gget('csv_f'),
				-font  => "TKFN",
				-command => sub{
					gui_window::contxt_out::csv->open;
				},
			);

			$self->{m_b3_contxtout_spss} = $self->{m_b3_contxtout}->command(
				-label => kh_msg->gget('spss_f'),
				-font  => "TKFN",
				-command => sub{
					gui_window::contxt_out::spss->open;
				},
			);

			$self->{m_b3_contxtout_tab} = $self->{m_b3_contxtout}->command(
				-label => kh_msg->gget('tab_f'),
				-font  => "TKFN",
				-command => sub{
					gui_window::contxt_out::tab->open;
				},
			);

		$f_export->separator;

		$self->{t_txt_pickup} = $f_export->command(
			-label => kh_msg->get('partial'),#gui_window->gui_jchar('ÉôÊ¬¥Æ¥­¥¹¥È¤Î¼è¤ê½Ğ¤·'),
			-font => "TKFN",
			-command => sub{
					gui_window::txt_pickup->open;
				},
			-state => 'disable'
		);

		$self->{t_txt_html2mod} = $f_export->command(
			-label => kh_msg->get('to_csv'),#gui_window->gui_jchar('HTML¤«¤éCSV¤ËÊÑ´¹'),
			-font => "TKFN",
			-command => sub{
					gui_window::txt_html2csv->open;
				},
			-state => 'disable'
		);

		$f_export->separator;

		$self->{m_b0_export} = $f_export->command(
			-label => kh_msg->get('export_kh'),
			-font => "TKFN",
			-state => 'disable',
			-command =>
				sub{
						$self->mc_export_project;
					},
		);
		# export menu #1 (end)



		my $f_import = $f1->cascade(
				-label => kh_msg->get('import'),
				-font => "TKFN",
				-tearoff=>'no'
			);

		$f_import->command(
			-label => kh_msg->get('import_folder'),
			-font => "TKFN",
			-command =>
				sub{
						gui_window::import_folder->open;
					},
		);

		$f_import->command(
			-label => kh_msg->get('import_khc'),
			-font => "TKFN",
			-command =>
				sub{
						$self->mc_import_project;
					},
		);

		$f1->separator();
		
		$f1->command(
			-label => kh_msg->get('config'),
			-font => "TKFN",
			-command => 
				sub{gui_window::sysconfig->open;},
		);
		#$f->separator();
		
		$f1->command(
			-label => kh_msg->get('exit'),
			-font => "TKFN",
			-command => sub{
						$::main_gui->get('main_window')->close or exit;
					},
			-accelerator => 'Ctrl+Q'
		);

	#------------#
	#   Á°½èÍı   #

	$underline_pos = index(kh_msg->get('prep'), 'R');
	$underline_pos = 0 if $underline_pos == -1;
	my $f = $menubar->cascade(
		-label => gui_window->gui_jm( kh_msg->get('prep') ),
		-font => "TKFN",
		-underline => $underline_pos,
		-tearoff=>'no'
	);
	
		if (
			   ($::config_obj->os       eq 'win32')
			&& ($::config_obj->msg_lang eq 'jp'   )
		) {
			my $plugin_path =
				$::config_obj->cwd.'/screen/MonkinCleanser/MonkinCleanser.exe'
			;
			if (-e $plugin_path) {
				#SCREEN Plugin
				use screen_code::rde_menu;
				&screen_code::rde_menu::add_menu($self,$f,\@menu0);
				#SCREEN Plugin
			} else {
				$self->{m_b0_editdata} = $f->command(
					-label => kh_msg->get('plugin_raw_data_editor2'),
					-font => "TKFN",
					-command => sub{
						gui_OtherWin->open('https://khcoder.net/scr_monkin.html');
					},
					-state => 'disable'
				);
			}
		}

		$self->{m_b2_datacheck} = $f->command(
				-label => kh_msg->get('check'),
				-font => "TKFN",
				-command => sub{
					my $ans = $mw->messageBox(
						-message => kh_msg->gget('cont_big_pros'),
						-icon    => 'question',
						-type    => 'OKCancel',
						-title   => 'KH Coder'
					);
					unless ($ans =~ /ok/i){ return 0; }
					$self->mc_datacheck;
				},
				-state => 'disable'
			);

		$self->{m_b2_morpho} = $f->command(
				-label => kh_msg->get('run_prep'),
				-font => "TKFN",
				-command => sub{ $self->mc_morpho_dialog; },
				-state => 'disable'
			);
		$f->separator();
		$self->{m_b1_mark} = $f->command(
				-label => kh_msg->get('words_selection'),
				-font => "TKFN",
				-command => sub{
					gui_window::dictionary->open;
				},
				-state => 'disable'
			);

		my $f_hukugo = $f->cascade(
				-label => kh_msg->get("words_cluster"),
				-font => "TKFN",
				-tearoff=>"no"
			);

		$self->{m_b1_hukugo_te} = $f_hukugo->command(
				-label => kh_msg->get("use_termextract"),
				-font => "TKFN",
				-command => sub{
						my $w = gui_wait->start;
					use mysql_hukugo;
					mysql_hukugo->run_from_morpho;
					$w->end;
					my $w = gui_wait->start;
					use mysql_nounphrases;
					mysql_nounphrases->detect;
					$w->end;
					use gui_window::noun_phrases;
					gui_window::noun_phrases->open;
				},
				-state => "disable"
			);

		$self->{m_b1_hukugo_np} = $f_hukugo->command(
				-label => kh_msg->get('noun_phrases'),
				-font => "TKFN",
				-command => sub{
					$self->mc_noun_phrases;
				},
				-state => 'disable'
			);

		$self->{m_b1_hukugo} = $f_hukugo->command(
				-label => kh_msg->get('use_chasen'), #gui_window->gui_jchar('Ããä¥¤Ë¤è¤ëÏ¢·ë'),
				-font => "TKFN",
				-command => sub{
					$self->mc_hukugo;
				},
				-state => 'disable'
			);
			
		if (
			   ($::config_obj->os       eq 'win32')
			&& ($::config_obj->msg_lang eq 'jp'   )
		) {
			my $plugin_path =
				$::config_obj->cwd.'/screen/MonkinSynonym/MonkinSynonym.exe';
			if (-e $plugin_path) {
				#SCREEN Plugin
				use screen_code::synonym_menu;
				&screen_code::synonym_menu::add_menu_exec_plugin($self,$f,\@menu1);
				#SCREEN Plugin
			} else {
				# ¤Á¤ç¤Ã¤È¸¡Æ¤Ãæ¡£¥³¥á¥ó¥È¥¢¥¦¥È¤ò³°¤¹¾ì¹ç¤Ï¡Öm_b0_editdata¡×¤òÊÌ¤ÎÌ¾Á°¤Ë¡£
				$self->{m_b2_no_synonym} = $f->command(
					-label => kh_msg->get('plugin_synonym2'),
					-font => "TKFN",
					-command => sub{
						gui_OtherWin->open('http://khcoder.net/scr_monkin.html');
					},
					-state => 'disable'
				);
				push @menu0, 'm_b2_no_synonym';
			}
		}

		$f->separator();

		$self->{m_b3_check} = $f->command(
				-label => kh_msg->get('check_morpho'), #gui_window->gui_jchar('¸ì¤ÎÃê½Ğ·ë²Ì¤ò³ÎÇ§'),
				-font => "TKFN",
				-command => sub{
					gui_window::morpho_check->open;
				},
				-state => 'disable'
			);

	#------------#
	#   ¥Ä¡¼¥ë   #

	$underline_pos = index(kh_msg->get('tools'), 'T');
	$underline_pos = 0 if $underline_pos == -1;
	$f = $menubar->cascade(
		-label => gui_window->gui_jm( kh_msg->get('tools') ),
		-font => "TKFN",
		-underline => $underline_pos,
		-tearoff=>'no'
	);

	my $f3 = $f->cascade(
			-label => kh_msg->get('words'),#gui_window->gui_jchar('Ãê½Ğ¸ì'),
			-font => "TKFN",
			-tearoff=>'no'
		);

		$self->{t_word_search} = $f3->command(
				-label => kh_msg->get('word_search'),#gui_window->gui_jchar('Ãê½Ğ¸ì¸¡º÷'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_search->open;
				},
				-state => 'disable'
			);
		
		#SCREEN Plugin
		use screen_code::word_cloud;
		&screen_code::word_cloud::add_word_cloud_menu($self,$f3,\@menu1);
		#SCREEN Plugin

		my $f_wd_stats = $f3->cascade(
			-label => kh_msg->get('desc_stats'),
			-font => "TKFN",
			-tearoff=>'no'
		);
		
		$self->{t_word_freq} = $f_wd_stats->command(
				-label => kh_msg->get('freq_tf'),#gui_window->gui_jchar('½Ğ¸½²ó¿ô¤ÎÊ¬ÉÛ'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_freq->open->count;
				},
				-state => 'disable'
			);

		$self->{t_word_df_freq} = $f_wd_stats->command(
				-label => kh_msg->get('freq_df'),#gui_window->gui_jchar('Ê¸½ñ¿ô¤ÎÊ¬ÉÛ'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_df_freq->open->count;
				},
				-state => 'disable'
			);

		$self->{t_word_tf_df} = $f_wd_stats->command(
				-label => kh_msg->get('tf_df'),#gui_window->gui_jchar('½Ğ¸½²ó¿ô£øÊ¸½ñ¿ô¤Î¥×¥í¥Ã¥È'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_tf_df->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_word_tf_df' if $::config_obj->R;

		$f3->separator;

		$self->{t_word_conc} = $f3->command(
				-label => kh_msg->get('kwic'),#gui_window->gui_jchar('KWIC¥³¥ó¥³¡¼¥À¥ó¥¹'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_conc->open;
				},
				-state => 'disable'
			);

		$self->{t_word_ass} = $f3->command(
				-label => kh_msg->get('word_ass'),#gui_window->gui_jchar('´ØÏ¢¸ìÃµº÷'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_ass->open;
				},
				-state => 'disable'
			);

		$f3->separator;

		$self->{t_word_corresp} = $f3->command(
				-label => kh_msg->get('corresp'),#gui_window->gui_jchar('ÂĞ±şÊ¬ÀÏ'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_corresp->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_word_corresp' if $::config_obj->R;

		$self->{t_word_mds} = $f3->command(
				-label => kh_msg->get('mds'),#gui_window->gui_jchar('Â¿¼¡¸µ¼ÜÅÙ¹½À®Ë¡'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_mds->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_word_mds' if $::config_obj->R;

		$self->{t_word_cls} = $f3->command(
				-label => kh_msg->get('h_cluster'),#gui_window->gui_jchar('³¬ÁØÅª¥¯¥é¥¹¥¿¡¼Ê¬ÀÏ'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_cls->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_word_cls' if $::config_obj->R;

		$self->{t_word_netgraph} = $f3->command(
				-label => kh_msg->get('netg'),#gui_window->gui_jchar('¶¦µ¯¥Í¥Ã¥È¥ï¡¼¥¯'),
				-font => "TKFN",
				-command => sub{
					gui_window::word_netgraph->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_word_netgraph' if $::config_obj->R;

		$self->{t_word_som} = $f3->command(
				-label => kh_msg->get('som'), # ¼«¸ÊÁÈ¿¥²½¥Ş¥Ã¥×
				-font => "TKFN",
				-command => sub{
					gui_window::word_som->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_word_som' if $::config_obj->R;

	my $f8 = $f->cascade(
			-label => kh_msg->get('docs'),#gui_window->gui_jchar('Ê¸½ñ'),
			-font => "TKFN",
			-tearoff=>'no'
		);

		$self->{t_doc_search} = $f8->command(
				-label => kh_msg->get('doc_search'),#gui_window->gui_jchar('Ê¸½ñ¸¡º÷'),
				-font => "TKFN",
				-command => sub{
					gui_window::doc_search->open;
				},
				-state => 'disable'
			);

		$self->{t_doc_cls} = $f8->command(
				-label => kh_msg->get('cluster'),#gui_window->gui_jchar('¥¯¥é¥¹¥¿¡¼Ê¬ÀÏ'),
				-font => "TKFN",
				-command => sub{
					gui_window::doc_cls->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_doc_cls' if $::config_obj->R;

	my $f_topic = $f8->cascade(
			-label => kh_msg->get('topic'), # ¥È¥Ô¥Ã¥¯¥â¥Ç¥ë
			 -font => "TKFN",
			 -tearoff=>'no'
		);

		$self->{t_topic_pp} = $f_topic->command(
			-label => kh_msg->get('topic_pp'), # ¥È¥Ô¥Ã¥¯¿ô¤ÎÃµº÷¡ÊPerplexity¡Ë
			-font => "TKFN",
			-command => sub{
					gui_window::topic_perplexity->open;
				},
			-state => 'disable'
		);

		$self->{t_topic_ft} = $f_topic->command(
			-label => kh_msg->get('topic_ft'), # ¥È¥Ô¥Ã¥¯¤Î¿äÄê
			-font => "TKFN",
			-command => sub{
					gui_window::topic_fitting->open;
				},
			-state => 'disable'
		);

		$self->{t_cas_bayes} = $f8->cascade(
			-label => kh_msg->get('docs_bayes'),#gui_window->gui_jchar('¥Ù¥¤¥º³Ø½¬¤Ë¤è¤ëÊ¬Îà'),
			 -font => "TKFN",
			 -tearoff=>'no'
		);

		$self->{t_bayes_learn} = $self->{t_cas_bayes}->command(
			-label => kh_msg->get('bayes_learn'),#gui_window->gui_jchar('³°ÉôÊÑ¿ô¤«¤é³Ø½¬'),
			-font => "TKFN",
			-command => sub{
				gui_window::bayes_learn->open;
			},
			-state => 'disable'
		);

		$self->{t_bayes_predict} = $self->{t_cas_bayes}->command(
			-label => kh_msg->get('bayes_classi'),#gui_window->gui_jchar('³Ø½¬·ë²Ì¤òÍÑ¤¤¤¿¼«Æ°Ê¬Îà'),
			-font => "TKFN",
			-command => sub{
				gui_window::bayes_predict->open;
			},
			-state => 'disable'
		);

		$self->{t_cas_bayes}->separator;

		$self->{t_bayes_view} = $self->{t_cas_bayes}->command(
			-label => kh_msg->get('check_learning'),#gui_window->gui_jchar('³Ø½¬·ë²Ì¥Õ¥¡¥¤¥ë¤ÎÆâÍÆ¤ò³ÎÇ§'),
			-font => "TKFN",
			-command => sub{
				$self->mc_view_knb;
			},
			-state => 'disable'
		);

		$self->{t_bayes_view_log} = $self->{t_cas_bayes}->command(
			-label => kh_msg->get('check_classi'),#gui_window->gui_jchar('Ê¬Îà¥í¥°¥Õ¥¡¥¤¥ë¤ÎÆâÍÆ¤ò³ÎÇ§'),
			-font => "TKFN",
			-command => sub{
				$self->mc_view_nbl;
			},
			-state => 'disable'
		);



	my $f5 = $f->cascade(
			-label => kh_msg->get('coding'),#gui_window->gui_jchar('¥³¡¼¥Ç¥£¥ó¥°'),
			 -font => "TKFN",
			 -tearoff=>'no'
		);

		$self->{t_cod_count} = $f5->command(
			-label => kh_msg->get('freq'),#gui_window->gui_jchar('Ã±½ã½¸·×'),
			-font => "TKFN",
			-command => sub{
					gui_window::cod_count->open;
				},
			-state => 'disable'
		);

		$self->{t_cod_outtab} = $f5->command(
			-label => kh_msg->get('cross_vr'),#gui_window->gui_jchar('³°ÉôÊÑ¿ô¤È¤Î¥¯¥í¥¹½¸·×'),
			-font => "TKFN",
			-command => sub{
					gui_window::cod_outtab->open;
				},
			-state => 'disable'
		);

		$self->{t_cod_jaccard} = $f5->command(
			-label => kh_msg->get('jac_mtrx'),#gui_window->gui_jchar('Îà»÷ÅÙ¹ÔÎó'),
			-font => "TKFN",
			-command => sub{
					gui_window::cod_jaccard->open;
				},
			-state => 'disable'
		);

		$f5->separator();

		$self->{t_cod_corresp} = $f5->command(
				-label => kh_msg->get('corresp'),#gui_window->gui_jchar('ÂĞ±şÊ¬ÀÏ'),
				-font => "TKFN",
				-command => sub{
					gui_window::cod_corresp->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_cod_corresp' if $::config_obj->R;

		#$self->{t_cod_multi} = $f5->cascade(
		#	-label => gui_window->gui_jchar('¥³¡¼¥É´Ö´ØÏ¢'),
		#	 -font => "TKFN",
		#	 -tearoff=>'no'
		#);

		$self->{t_cod_mds} = $f5->command(
				-label => kh_msg->get('mds'),#gui_window->gui_jchar('Â¿¼¡¸µ¼ÜÅÙ¹½À®Ë¡'),
				-font => "TKFN",
				-command => sub{
					gui_window::cod_mds->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_cod_mds' if $::config_obj->R;

		$self->{t_cod_cls} = $f5->command(
				-label => kh_msg->get('h_cluster'),
				-font => "TKFN",
				-command => sub{
					gui_window::cod_cls->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_cod_cls' if $::config_obj->R;

		$self->{t_cod_netg} = $f5->command(
				-label => kh_msg->get('netg'),#gui_window->gui_jchar('¶¦µ¯¥Í¥Ã¥È¥ï¡¼¥¯'),
				-font => "TKFN",
				-command => sub{
					gui_window::cod_netg->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_cod_netg' if $::config_obj->R;

		$self->{t_cod_som} = $f5->command(
				-label => kh_msg->get('som'), # ¼«¸ÊÁÈ¿¥²½¥Ş¥Ã¥×
				-font => "TKFN",
				-command => sub{
					gui_window::cod_som->open;
				},
				-state => 'disable'
			);
		push @menu1, 't_cod_som' if $::config_obj->R;

	$f->separator();

	$self->{t_out_list} = $f->command(
		-label => kh_msg->get('vars_heads'), # ³°ÉôÊÑ¿ô
		-font => "TKFN",
		-command => sub{
				gui_window::outvar_list->open;
			},
		-state => 'disable'
	);

	$f->separator();

	# export menu #2
	my $f_export2 = $f->cascade(
			-label => kh_msg->get('export'),
			-font => "TKFN",
			-tearoff=>'no'
		);

	$self->{t_word_list_cf2} = $f_export2->command(
			-label => kh_msg->get('word_freq'), # Ãê½Ğ¸ì¥ê¥¹¥È
			-font => "TKFN",
			-command => sub{
				gui_window::word_list->open;
			},
			-state => 'disable'
		);

	$f_export2->separator;
	
	$self->{m_b3_crossout2} = $f_export2->cascade(
			-label => kh_msg->get('doc_term_mtrx'), # ¡ÖÊ¸½ñ£øÃê½Ğ¸ì¡×É½¤Î½ĞÎÏ
			-font => "TKFN",
			-state => 'disable',
			-tearoff=>'no'
		);

		$self->{m_b3_crossout_csv2} = $self->{m_b3_crossout2}->command(
			-label => kh_msg->gget('csv_f'), # CSV¥Õ¥¡¥¤¥ë"
			-font  => "TKFN",
			-command => sub{
				gui_window::morpho_crossout::csv->open;
			},
		);

		$self->{m_b3_crossout_spss2} = $self->{m_b3_crossout2}->command(
			-label => kh_msg->gget('spss_f'), # SPSS¥Õ¥¡¥¤¥ë
			-font  => "TKFN",
			-command => sub{
				gui_window::morpho_crossout::spss->open;
			},
		);

		$self->{m_b3_crossout_tab2} = $self->{m_b3_crossout2}->command(
			-label => kh_msg->gget('tab_f'), # ¥¿¥Ö¶èÀÚ¤ê
			-font  => "TKFN",
			-command => sub{
				gui_window::morpho_crossout::tab->open;
			},
		);

		$self->{m_b3_crossout2}->separator;

		$self->{m_b3_crossout_var2} = $self->{m_b3_crossout2}->command(
			-label => kh_msg->gget('wm_f'), # ÉÔÄêÄ¹CSV ¡ÊWordMiner¡Ë
			-font  => "TKFN",
			-command => sub{
				gui_window::morpho_crossout::var->open;
			},
		);

	$self->{t_cod_out2} = $f_export2->cascade(
		-label => kh_msg->get('output_cod'), # ¥³¡¼¥Ç¥£¥ó¥°·ë²Ì¤Î½ĞÎÏ
		 -font => "TKFN",
		 -tearoff=>'no'
	);

		$self->{t_cod_out_csv2} = $self->{t_cod_out2}->command(
			-label => kh_msg->gget('csv_f'), # CSV¥Õ¥¡¥¤¥ë
			-font => "TKFN",
			-command => sub{
					gui_window::cod_out::csv->open;
				},
			-state => 'disable'
		);

		$self->{t_cod_out_spss2} = $self->{t_cod_out2}->command(
			-label => kh_msg->gget('spss_f'), # SPSS¥Õ¥¡¥¤¥ë
			-font => "TKFN",
			-command => sub{
					gui_window::cod_out::spss->open;
				},
			-state => 'disable'
		);

		$self->{t_cod_out_tab2} = $self->{t_cod_out2}->command(
			-label => kh_msg->gget('tab_f'), # ¥¿¥Ö¶èÀÚ¤ê
			-font => "TKFN",
			-command => sub{
					gui_window::cod_out::tab->open;
				},
			-state => 'disable'
		);

		$self->{t_cod_out2}->separator();

		$self->{t_cod_out_var2} = $self->{t_cod_out2}->command(
			-label => kh_msg->gget('wm_f'), # ÉÔÄêÄ¹CSV ¡ÊWordMiner¡Ë
			-font => "TKFN",
			-command => sub{
					gui_window::cod_out::var->open;
				},
			-state => 'disable'
		);

	$self->{m_b3_contxtout2} = $f_export2->cascade(
			-label => kh_msg->get('term_vec_mtrx'), # ¡ÖÃê½Ğ¸ì£øÊ¸Ì®¥Ù¥¯¥È¥ë¡×
			-font => "TKFN",
			-state => 'disable',
			-tearoff=>'no'
		);

		$self->{m_b3_contxtout_csv2} = $self->{m_b3_contxtout2}->command(
			-label => kh_msg->gget('csv_f'),
			-font  => "TKFN",
			-command => sub{
				gui_window::contxt_out::csv->open;
			},
		);

		$self->{m_b3_contxtout_spss2} = $self->{m_b3_contxtout2}->command(
			-label => kh_msg->gget('spss_f'),
			-font  => "TKFN",
			-command => sub{
				gui_window::contxt_out::spss->open;
			},
		);

		$self->{m_b3_contxtout_tab2} = $self->{m_b3_contxtout2}->command(
			-label => kh_msg->gget('tab_f'),
			-font  => "TKFN",
			-command => sub{
				gui_window::contxt_out::tab->open;
			},
		);

	$f_export2->separator;

	$self->{t_txt_pickup2} = $f_export2->command(
		-label => kh_msg->get('partial'), # ÉôÊ¬¥Æ¥­¥¹¥È¤Î¼è¤ê½Ğ¤·
		-font => "TKFN",
		-command => sub{
				gui_window::txt_pickup->open;
			},
		-state => 'disable'
	);

	$self->{t_txt_html2mod2} = $f_export2->command(
		-label => kh_msg->get('to_csv'), # HTML¤«¤éCSV¤ËÊÑ´¹
		-font => "TKFN",
		-command => sub{
				gui_window::txt_html2csv->open;
			},
		-state => 'disable'
	);

	$f_export2->separator;

	$self->{m_b0_export2} = $f_export2->command(
		-label => kh_msg->get('export_kh'),
		-font => "TKFN",
		-state => 'disable',
		-command =>
			sub{
					$self->mc_export_project;
				},
	);
	# export menu #2 (end)



	# ¥×¥é¥°¥¤¥ó¤ÎÆÉ¤ß¹ş¤ß
	my $f_p = $f->cascade(
			-label => kh_msg->get('plugin'),#gui_window->gui_jchar('¥×¥é¥°¥¤¥ó'),
			-font => "TKFN",
			-tearoff=>'no'
		);

	my @plugins;
	my $read_each = sub {
		return if (-d $File::Find::name);
		return if ($File::Find::name =~ /\/\.svn/);
		return unless $_ =~ /.+\.pm/;
		substr($_, length($_) - 3, length($_)) = '';
		push @plugins, $_;
	};

	use File::Find;
	my $plugin_lang = Encode::encode( 'utf8', $::config_obj->msg_lang );
	unless (-d $::config_obj->cwd.'/plugin_'.$plugin_lang){
		$plugin_lang = 'en';
	}
	use File::Find;
	push @INC, $::config_obj->cwd.'/plugin_'.$plugin_lang;
	find(
		{
			preprocess => sub {sort {$a cmp $b} @_},
			wanted     => $read_each
		},
		$::config_obj->cwd.'/plugin_'.$plugin_lang
	);

	foreach (@plugins){
		unless (eval "use $_; 1"){
			my $err = $@;
			gui_errormsg->open(
				type => 'msg',
				msg  => "plugin error at ".$_.".pm\n\nerror: \n$err"
			);
			print "$err\n";
			return 0;
		}
		my $conf = $_->plugin_config;
		unless ( defined($conf) ){
			next;
		}
		
		my $cu = $_;
		my $mother = $f_p;
		
		# ¥°¥ë¡¼¥×»ØÄê¤ËÂĞ±ş
		if ( length($conf->{menu_grp}) ){
			unless ( $self->{plugin_cascades}{$conf->{menu_grp}} ){
				$self->{plugin_cascades}{$conf->{menu_grp}} = $f_p->cascade(
					-label   => gui_window->gui_jchar($conf->{menu_grp}),
					-font    => "TKFN",
					-tearoff =>'no'
				);
			}
			$mother = $self->{plugin_cascades}{$conf->{menu_grp}};
		}
		
		# ¥á¥Ë¥å¡¼¥³¥Ş¥ó¥ÉºîÀ®
		my $tmp_menu = $mother->command(
				-label => gui_window->gui_jchar($conf->{name}),
				-font => "TKFN",
				-command => sub{
					$cu->exec;
				},
				-state => 'disable'
		);
		
		# ¥á¥Ë¥å¡¼ÀßÄê
		$conf->{menu_cnf} = 0 unless defined($conf->{menu_cnf});
		if ($conf->{menu_cnf} == 0){
			$tmp_menu->configure(-state, 'normal');
		}
		elsif ($conf->{menu_cnf} == 1){
			$self->{'t_plugin_'.$_} = $tmp_menu;
			push @menu0, 't_plugin_'.$_;
		}
		elsif ($conf->{menu_cnf} == 2){
			$self->{'t_plugin_'.$_} = $tmp_menu;
			push @menu1, 't_plugin_'.$_;
		}
	}



	$self->{t_sql_select} = $f->command(
			-label => kh_msg->get('exec_sql'),#gui_window->gui_jchar('SQLÊ¸¤Î¼Â¹Ô'),
			-font => "TKFN",
			-command => sub{
				gui_window::sql_select->open;
			},
			-state => 'disable'
		);

	#------------#
	#   ¥Ø¥ë¥×   #

	$underline_pos = index(kh_msg->get('help'), 'H');
	$underline_pos = 0 if $underline_pos == -1;
	$f = $menubar->cascade(
		-label => gui_window->gui_jm( kh_msg->get('help') ),#"$msg",
		-font => "TKFN",
		-underline => $underline_pos,
		-tearoff=>'no'
	);
	
	if ($::config_obj->{msg_lang} eq 'jp') {
		$f->command(
			-label => kh_msg->get('book2'),
			-font => "TKFN",
			-command => sub {
				 gui_OtherWin->open('https://amzn.to/3LdRHMJ');
			},
		);
		$f->command(
			-label => kh_msg->get('book1'),
			-font => "TKFN",
			-command => sub {
				 gui_OtherWin->open('http://amzn.to/2wHFxKg');
			},
		);
		if (-e 'khcoder_manual.pdf') {
			$f->command(
				-label => kh_msg->get('man'),
				-font => "TKFN",
				-command => sub {
					gui_OtherWin->open('khcoder_manual.pdf');
				},
			);
		}
		
	}

	unless ($::config_obj->{msg_lang} eq 'jp') {
		$f->command(
			-label => kh_msg->get('man'),
			-font => "TKFN",
			-command => sub {
				gui_OtherWin->open('khcoder_manual_en.pdf');
			},
		);
	}

	$f->command(
		-label => kh_msg->get('web'),
		-font => "TKFN",
		-command => sub {
				 gui_OtherWin->open('https://khcoder.net');
				},
	);

	$f->command(
		-label => kh_msg->get('suggest'),
		-font => "TKFN",
		-command => sub{gui_window::suggest->open;},
		#-accelerator => 'Alt + S',
	);

	$f->command(
		-label => kh_msg->get('about'),
		-command => sub{gui_window::about->open;},
		-font => "TKFN",
	);

	#--------------------#
	#   ¥­¡¼¡¦¥Ğ¥¤¥ó¥É   #
	
	$mw->bind(
		'<Control-Key-o>',
		sub{gui_window::project_open->open;}
	);
	$mw->bind(
		'<Control-Key-n>',
		sub{gui_window::project_new->open;}
	);
	$mw->bind(
		'<Control-Key-v>',
		sub{gui_window::about->open;}
	);
	$mw->bind(
		'<Control-Key-w>',
		sub{$self->mc_close_project;}
	);

	# For Mac OS X
	if ($^O =~ /darwin/i ){
		$mw->bind(
			'<p>',
			sub{
				$menubar->Post(10, 10, 1);
				$menubar->NextMenu('right');
			}
		);
		$mw->bind(
			'<r>',
			sub{
				$menubar->Post(10, 10, 2);
				$menubar->NextMenu('right');
			}
		);
		$mw->bind(
			'<t>',
			sub{
				$menubar->Post(10, 10, 3);
				$menubar->NextMenu('right');
			}
		);
		$mw->bind(
			'<h>',
			sub{
				$menubar->Post(10, 10, 4);
				$menubar->NextMenu('right');
			}
		);
	}
	
	bless $self, $class;
	return $self;
}

#------------------------------------#
#   °ì¹Ô¤ò±Û¤¨¤ë¥á¥Ë¥å¡¼¡¦¥³¥Ş¥ó¥É   #
#------------------------------------#

sub mc_view_nbl{
	my @types = (
		[ "KH Coder: Naive Bayes Logs",[qw/.nbl/] ],
		["All files",'*']
	);
	my $path = $::main_gui->mw->getOpenFile(
		-defaultextension => '.nbl',
		-filetypes        => \@types,
		-title            =>
			gui_window->gui_jt( kh_msg->get('open_nbl') ), # ±ÜÍ÷¤¹¤ëÊ¬Îà¥í¥°¥Õ¥¡¥¤¥ë¤òÁªÂò
		-initialdir       => gui_window->gui_jchar($::config_obj->cwd),
	);
	unless ($path){
		return 0;
	}
	$path = gui_window->gui_jg_filename_win98($path);
	$path = gui_window->gui_jg($path);
	$path = $::config_obj->os_path($path);
	
	my $win = $::main_gui->get('w_bayes_view_log');
	$win->close if Exists( $win->{win_obj} );
	
	gui_window::bayes_view_log->open($path);
}

sub mc_view_knb{
	my @types = (
		[ "KH Coder: Naive Bayes Moldels",[qw/.knb/] ],
		["All files",'*']
	);
	my $path = $::main_gui->mw->getOpenFile(
		-defaultextension => '.knb',
		-filetypes        => \@types,
		-title            =>
			gui_window->gui_jt( kh_msg->get('open_knb') ), # ±ÜÍ÷¤¹¤ë³Ø½¬·ë²Ì¥Õ¥¡¥¤¥ë¤òÁªÂò
		-initialdir       => gui_window->gui_jchar($::config_obj->cwd),
	);
	unless ($path){
		return 0;
	}
	$path = gui_window->gui_jg_filename_win98($path);
	$path = gui_window->gui_jg($path);
	$path = $::config_obj->os_path($path);
	
	my $win = $::main_gui->get('w_bayes_view_knb');
	$win->close if Exists( $win->{win_obj} );
	
	gui_window::bayes_view_knb->open($path);
	
	# my $dist = $::project_obj->file_TempCSV;
	# kh_nbayes::Util->knb2csv(
	# 	path => $path,
	# 	csv  => $dist,
	# );
	# gui_OtherWin->open($dist);
}
sub mc_import_project{
	require kh_project_io;

	# KHC¥Õ¥¡¥¤¥ë¤Î¥Ñ¥¹
	my @types = (
		['KH Coder',[qw/.khc/] ],
		["All Files",'*']
	);
	my $path = $::main_gui->mw->getOpenFile(
		-defaultextension => '.khc',
		-filetypes        =>  \@types,
		-title            =>
			gui_window->gui_jt( kh_msg->get('import_win_title') ),
		-initialdir       => gui_window->gui_jchar($::config_obj->cwd),
	);
	unless ($path){
		return 0;
	}
	$path = gui_window->gui_jg_filename_win98($path);
	$path = gui_window->gui_jg($path);
	$path = $::config_obj->os_path($path);
	
	# Ê¬ÀÏÂĞ¾İ¥Õ¥¡¥¤¥ë¤ÎÊİÂ¸¾ì½ê
	my $info = &kh_project_io::get_info($path);
	return undef unless length($info->{file_name});
	@types = (
		['Data Files',[qw/.txt .docx .doc .xls .xlsx .csv .tsv/] ],
		["All Files",'*']
	);
	my $path_s = $::main_gui->mw->getSaveFile(
		-defaultextension => '.khc',
		-filetypes        =>  \@types,
		-title            =>
			gui_window->gui_jt( kh_msg->get('import_save_path') ),
		-initialdir       => gui_window->gui_jchar($::config_obj->cwd),
		-initialfile      => gui_window->gui_jchar($info->{file_name})
	);
	unless ($path_s){
		return 0;
	}
	$path_s = gui_window->gui_jg_filename_win98($path_s);
	$path_s = gui_window->gui_jg($path_s);
	$path_s = $::config_obj->os_path($path_s);
	
	# ¼Â¹Ô
	my $w = gui_wait->start;
	&kh_project_io::import($path,$path_s);
	$w->end;
	
	# ¥×¥í¥¸¥§¥¯¥È¥Ş¥Í¡¼¥¸¥ã¡¼¤òÉ½¼¨
	gui_window::project_open->open;

}
sub mc_export_project{
	require kh_project_io;

	# ¥Õ¥¡¥¤¥ëÌ¾
	my @types = (
		['KH Coder',[qw/.khc/] ],
		["All Files",'*']
	);
	my $path = $::main_gui->mw->getSaveFile(
		-defaultextension => '.khc',
		-filetypes        =>  \@types,
		-title            =>
			gui_window->gui_jt( kh_msg->get('export_win_title') ),
		-initialdir       => gui_window->gui_jchar($::config_obj->cwd),
	);
	unless ($path){
		return 0;
	}
	$path = gui_window->gui_jg_filename_win98($path);
	$path = gui_window->gui_jg($path);
	$path = $::config_obj->os_path($path);
	
	# ¼Â¹Ô
	my $w = gui_wait->start;
	&kh_project_io::export($path);
	$w->end;
}
sub mc_close_project{
	$::main_gui->close_all;
	undef $::project_obj;
	$::main_gui->menu->refresh;
	$::main_gui->inner->refresh;
	#SCREEN Plugin
	use screen_code::r_plot_multiselect;
	screen_code::r_plot_multiselect::close_KWIC();
	#SCREEN Plugin
}
sub mc_datacheck{
	my $w = gui_wait->start;
	use kh_datacheck;
	kh_datacheck->run;
	$w->end(no_dialog => 1);
}
sub mc_morpho_dialog{
	my $self = shift;
	my $mw = $::main_gui->{win_obj};

	#SCREEN Plugin
	use screen_code::negationchecker;
	return 0 if screen_code::negationchecker::plugin_dialog($self,$mw);
	#SCREEN Plugin
	
	my $reload = 0;
	if ( $::project_obj->reloadable ){
		my $ans = $mw->messageBox(
			-message => kh_msg->get('prepro_reload'),
			-icon    => 'question',
			-type    => 'YesNoCancel',
			-title   => 'KH Coder'
		);
		if ($ans =~ /cancel/i){ return 0; }
		if ($ans =~ /Yes/i) {   $reload = 1; }
	} else {

		if ($^O eq 'darwin') {
		#if (1) {
			print "Trying out a different dialog method for darwin...\n";
			require Tk::Dialog;
			my $dialog_win = $mw->Dialog(
				-title => 'KH Coder',
				-text => kh_msg->gget('cont_big_pros'),
				-bitmap => 'question',
				-default_button => 'OK',
				-buttons => [kh_msg->gget('ok'),kh_msg->gget('cancel')],
			);
			my $ans = $dialog_win->Show(-popover => $::main_gui->mw);
			my $ok = kh_msg->gget('ok');
			unless ($ans =~ /$ok/i){ return 0; }
		} else {
			my $ans = $mw->messageBox(
				-message => Encode::decode_utf8('å‰å‡¦ç†ã‚’å®Ÿè¡Œã—ã¾ã™ã‹ï¼Ÿ'),
				-icon    => 'question',
				-type    => 'OKCancel',
				-title   => 'KH Coder'
			);
			unless ($ans =~ /ok/i){ return 0; }
		}

	}
	$self->mc_morpho($reload);
}
sub mc_morpho{
	my $self = shift;
	my $reload = shift;
	
	#SCREEN Plugin
	use screen_code::r_plot_multiselect;
	screen_code::r_plot_multiselect::close_KWIC();
	#SCREEN Plugin
	$::main_gui->close_all;
	my $w = gui_wait->start;           # Show "please wait" window
	my $rtn = $self->mc_morpho_exec($reload);
	unless ( $rtn ){                   # when failed...
		$w->end(no_dialog => 1);
		return 0;
	}
	#SCREEN Plugin
	use screen_code::synonym_menu;
	&screen_code::synonym_menu::run_after_prep();
	#SCREEN Plugin
	$w->end;                           # Show "processing complete" window
	$::main_gui->menu->refresh;
	$::main_gui->inner->refresh;
}
sub mc_morpho_exec{
	my $self = shift;
	my $reload = shift;
	mysql_ready->first($reload) or return 0;
	$::project_obj->status_morpho(1);
	return 1;
}
sub mc_noun_phrases{
	my $self = shift;
	my $mw = $::main_gui->{win_obj};

	my $file_hukugo = $::config_obj->os_path( $::project_obj->file_NounPhrases );
	my $file_target = $::config_obj->os_path( $::project_obj->file_target );
	
	my $if_exec = 1;
	if (
		   ( -e $file_hukugo )
		&& ( mysql_exec->table_exists('noun_phrases') )
	){
		my $t0 = (stat $file_target)[9];
		my $t1 = (stat $file_hukugo)[9];
		if ($t0 < $t1){
			$if_exec = 0; # do not analyze
		}
	}
	
	if ($if_exec){
		my $ans = $mw->messageBox(
			-message => kh_msg->gget('cont_big_pros'),
			-icon    => 'question',
			-type    => 'OKCancel',
			-title   => 'KH Coder'
		);
		unless ($ans =~ /ok/i){ return 0; }

		my $w = gui_wait->start;
		use mysql_nounphrases;
		mysql_nounphrases->detect;
		$w->end;
	}

	use gui_window::noun_phrases;
	gui_window::noun_phrases->open;
}
sub mc_hukugo{
	my $self = shift;
	my $mw = $::main_gui->{win_obj};

	my $file_hukugo = $::config_obj->os_path( $::project_obj->file_HukugoList );
	my $file_target = $::config_obj->os_path( $::project_obj->file_target );
	
	my $if_exec = 1;
	if (
		   ( -e $file_hukugo )
		&& ( mysql_exec->table_exists('hukugo') )
	){
		my $t0 = (stat $file_target)[9];
		my $t1 = (stat $file_hukugo)[9];
		if ($t0 < $t1){
			$if_exec = 0; # ¤³¤Î¾ì¹ç¤À¤±²òÀÏ¤·¤Ê¤¤
		}
	}

	if ($if_exec){
		my $ans = $mw->messageBox(
			-message => kh_msg->gget('cont_big_pros'),
			-icon    => 'question',
			-type    => 'OKCancel',
			-title   => 'KH Coder'
		);
		unless ($ans =~ /ok/i){ return 0; }

		my $w = gui_wait->start;
		use mysql_hukugo;
		mysql_hukugo->run_from_morpho;
		$w->end;
	}

	use mysql_hukugo;
					my $exists = mysql_exec->select("SHOW TABLES LIKE 'hukugo'")->fetchrow_array;
					unless ($exists) {
						my $w = gui_wait->start;
						mysql_hukugo->run_from_morpho;
						$w->end;
					}
					gui_window::noun_phrases->open;
}


#------------------------#
#   ¥á¥Ë¥å¡¼¤Î¾õÂÖÊÑ¹¹   #
#------------------------#

sub refresh{
	my $self = shift;
	$self->disable_all;

	if ($::project_obj){
		$self->normalize(\@menu0);
		
		# morpho_analyzer
		if ($::config_obj->c_or_j eq 'chasen'){
			$self->normalize([
				'm_b1_hukugo',
				'm_b1_hukugo_te',
				'm_b1_hukugo_np',
				'm_b2_datacheck',
			]);
		}
		elsif ($::config_obj->c_or_j eq 'mecab'){
			$self->normalize([
				'm_b1_hukugo_te',
				'm_b1_hukugo_np',
				'm_b2_datacheck',
			]);
		}
		elsif (
			(
				( $::config_obj->c_or_j eq 'stanford' )
			 || ( $::config_obj->c_or_j eq 'freeling' )
			)
			&& $::project_obj->morpho_analyzer_lang eq 'en'
		){
			$self->normalize([
				'm_b1_hukugo_te',
				'm_b1_hukugo_np',
			]);
		}

		if ($::project_obj->status_morpho){
			$self->normalize(\@menu1);
		}
	}
}

sub normalize{
	my $self = shift;
	foreach my $i (@{$_[0]}){
		next unless $self->{$i};
		$self->{$i}->configure(-state,'normal');
	}
}

sub disable_all{
	my $self = shift;
	foreach my $i (keys %{$self}){
		if (substr($i,0,2) eq 'm_' || substr($i,0,2) eq 't_'){
			next unless $self->{$i};
			$self->{$i}->configure(-state, 'disable');
		}
	}
}

1;
