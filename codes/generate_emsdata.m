clearvars;
load subject_label12

% for replication
rng('default')

column_names = [...
    {'Sex'              };
    {'age'              };
    {'Education'        };
    {'Start_age'        };
    {'Disease_Years'    };
    {'CPZ_total'        };
    {'cognitive_decline'};
    {'PANSS_posi'       };
    {'PANSS_nega'       };
    {'PANSS_gps'        };
    {'PANSS_total'      };
    {'WAIS3_FIQ'        };
    {'VC'               };
    {'PO'               };
    {'WM'               };
    {'PS'               };
    {'WMSR_VerM'        };
    {'WMSR_ViM'         };
    {'WMSR_GM'          };
    {'WMSR_AC'          };
    {'WMSR_DR'          };
    {'UPSAB_social'     };
    {'SFS_total'        };
    {'work_hours'       };
    {'MainSeqA'         };
    {'MainSeqC'         };
    {'MainSeqO'         };
    {'FV_SacNum'        };
    {'FV_SacAmp'        };
    {'FV_SPL'           }];

emsdata = NaN(size(sc.demographics,1), length(column_names));
for ii=1:size(emsdata,2)
    emsdata(:,ii) = randn(size(sc.demographics,1),1);
end

save('emsdata0427d.mat','emsdata','column_names');
