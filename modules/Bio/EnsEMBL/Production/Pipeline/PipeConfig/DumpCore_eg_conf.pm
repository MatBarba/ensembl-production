=head1 LICENSE

Copyright [1999-2016] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=head1 NAME

 Bio::EnsEMBL::Production::Pipeline::PipeConfig::DumpCore_eg_conf;

=head1 DESCRIPTION

=head1 AUTHOR 

 ckong@ebi.ac.uk 

=cut
package Bio::EnsEMBL::Production::Pipeline::PipeConfig::DumpCore_eg_conf;

use strict;
use warnings;
use File::Spec;
use Data::Dumper;
use Bio::EnsEMBL::Hive::Version 2.3;
use Bio::EnsEMBL::ApiVersion qw/software_version/;
use base ('Bio::EnsEMBL::Production::Pipeline::PipeConfig::DumpCore_conf');     

   
sub default_options {
    my ($self) = @_;
    
    return {
       # inherit other stuff from the base class
       %{ $self->SUPER::default_options() }, 
       
#       'run_vep'			 => 1, # 0/1, Default => 1
       'vep_command'   		 => '--build all',
	   'perl_command'  		 => 'perl -I ~/Variation/modules',
       'perl_cmd'      		 => 'perl', # added
	   'blast_header_prefix' => 'EG:',
       'exe_dir'             => '/nfs/panda/ensemblgenomes/production/compara/binaries/',

       'ftpdir_vep'          => $self->o('ftp_dir').'/'.$self->o('vep_division').'/vep',
       'tempdir_vep'         => '/nfs/nobackup/ensemblgenomes/'.$self->o('ENV', 'USER').'/workspace/'.$self->o('pipeline_name').'/temp_dir/release-'.$self->o('release').'/'.$self->o('vep_division'),     
       'vep_div'             => $self->o('vep_division'),
	};
}

sub pipeline_analyses {
    my ($self) = @_;

    ## Get analyses defined in the base class
    my $super_analyses   = $self->SUPER::pipeline_analyses;

   	my $pipeline_flow;
   	
   	#9 dump types (1 combinations)
  	if ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
   	#8 dump types (9 combinations)    
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot']; }
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_ena']; }
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_tsv_uniprot', 'dump_tsv_ena']; }
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena') ) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena']; }
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena']; }
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];}    
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
   	#7 dump types (36 combinations)    
	    # 3 pairs, DROP tsv & tsv_ena, chain & tsv, chain & tsv_ena
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_tsv_uniprot')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_tsv_uniprot'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_tsv_ena'];} 
    	 # 3 pairs, DROP pep & chain, pep & tsv, pep & tsv_ena
   	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_chain', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_chain', 'dump_tsv_ena'];} 
	    # 4 pairs, DROP dna & pep, dna & chain, dna & tsv, dna & tsv_ena
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_pep', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot'];} 
    	# 5 pairs, DROP genbank & dna, genbank & pep, genbank & chain, genbank & tsv, genbank & tsv_ena
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_fasta_dna', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_embl', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot'];} 
	    # 6 pairs, DROP embl & genbank, embl & dna, embl & pep, embl & chain, embl & tsv, embl& ena
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_genbank', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_genbank', 'dump_fasta_dna', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_gff3', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot'];} 
    	# 7 pairs, DROP gff & embl, gff & genbank, gff & dna, gff & pep, gff & chain, gff & tsv, gff & tsv_ena
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
   	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_embl') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_embl', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
   	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_embl', 'dump_genbank', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
   	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
   	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
   	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_ena'];} 
   	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot')) {
    	$pipeline_flow  = ['dump_gtf', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot'];} 
    	# 8 pairs, DROP gtf & gff, gtf & embl, gtf & genbank, gtf & dna, gtf & pep, gtf & chain, gtf & tsv, gtf & tsv_ena
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gff3', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gff3', 'dump_embl', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_chain', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_tsv_uniprot', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_ena')) {
    	$pipeline_flow  = ['dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_embl') && $self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep') && $self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot')) {
    	$pipeline_flow  = ['dump_gff3', 'dump_embl', 'dump_genbank', 'dump_fasta_dna', 'dump_fasta_pep', 'dump_chain', 'dump_tsv_uniprot'];} 
   	#2 dump types ( 36 combinations)    
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_gff3')) 	     		{ $pipeline_flow  = ['dump_gtf', 'dump_gff3'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_embl')) 	     		{ $pipeline_flow  = ['dump_gtf', 'dump_embl'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_genbank'))     		{ $pipeline_flow  = ['dump_gtf', 'dump_genbank'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_fasta_dna'))   		{ $pipeline_flow  = ['dump_gtf', 'dump_fasta_dna'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_fasta_pep'))   		{ $pipeline_flow  = ['dump_gtf', 'dump_fasta_pep'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_chain')) 	     		{ $pipeline_flow  = ['dump_gtf', 'dump_chain'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_tsv_uniprot')) 		{ $pipeline_flow  = ['dump_gtf', 'dump_tsv_uniprot'];} 
  	elsif ($self->o('f_dump_gtf') && $self->o('f_dump_tsv_ena'))     		{ $pipeline_flow  = ['dump_gtf', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_embl')) 	     		{ $pipeline_flow  = ['dump_gff3', 'dump_embl'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_genbank'))    		{ $pipeline_flow  = ['dump_gff3', 'dump_genbank'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_fasta_dna'))  		{ $pipeline_flow  = ['dump_gff3', 'dump_fasta_dna'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_fasta_pep'))  		{ $pipeline_flow  = ['dump_gff3', 'dump_fasta_pep'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_chain'))  	 		{ $pipeline_flow  = ['dump_gff3', 'dump_chain'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_tsv_uniprot'))		{ $pipeline_flow  = ['dump_gff3', 'dump_tsv_uniprot'];} 
  	elsif ($self->o('f_dump_gff3') && $self->o('f_dump_tsv_ena'))    		{ $pipeline_flow  = ['dump_gff3', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_embl') && $self->o('f_dump_genbank'))    		{ $pipeline_flow  = ['dump_embl', 'dump_genbank'];} 
  	elsif ($self->o('f_dump_embl') && $self->o('f_dump_fasta_dna'))  		{ $pipeline_flow  = ['dump_embl', 'dump_fasta_dna'];} 
  	elsif ($self->o('f_dump_embl') && $self->o('f_dump_fasta_pep'))  		{ $pipeline_flow  = ['dump_embl', 'dump_fasta_pep'];} 
  	elsif ($self->o('f_dump_embl') && $self->o('f_dump_chain'))  	 		{ $pipeline_flow  = ['dump_embl', 'dump_chain'];} 
  	elsif ($self->o('f_dump_embl') && $self->o('f_dump_tsv_uniprot'))		{ $pipeline_flow  = ['dump_embl', 'dump_tsv_uniprot'];} 
  	elsif ($self->o('f_dump_embl') && $self->o('f_dump_tsv_ena'))    		{ $pipeline_flow  = ['dump_embl', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_genbank') && $self->o('f_dump_fasta_dna'))  	{ $pipeline_flow  = ['dump_genbank', 'dump_fasta_dna'];} 
  	elsif ($self->o('f_dump_genbank') && $self->o('f_dump_fasta_pep'))  	{ $pipeline_flow  = ['dump_genbank', 'dump_fasta_pep'];} 
  	elsif ($self->o('f_dump_genbank') && $self->o('f_dump_chain'))      	{ $pipeline_flow  = ['dump_genbank', 'dump_chain'];} 
  	elsif ($self->o('f_dump_genbank') && $self->o('f_dump_tsv_uniprot'))	{ $pipeline_flow  = ['dump_genbank', 'dump_tsv_uniprot'];} 
  	elsif ($self->o('f_dump_genbank') && $self->o('f_dump_tsv_ena'))    	{ $pipeline_flow  = ['dump_genbank', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_fasta_dna') && $self->o('f_dump_fasta_pep'))  	{ $pipeline_flow  = ['dump_fasta_dna', 'dump_fasta_pep'];} 
  	elsif ($self->o('f_dump_fasta_dna') && $self->o('f_dump_chain'))  		{ $pipeline_flow  = ['dump_fasta_dna', 'dump_chain'];} 
  	elsif ($self->o('f_dump_fasta_dna') && $self->o('f_dump_tsv_uniprot'))  { $pipeline_flow  = ['dump_fasta_dna', 'dump_tsv_uniprot'];} 
  	elsif ($self->o('f_dump_fasta_dna') && $self->o('f_dump_tsv_ena'))  	{ $pipeline_flow  = ['dump_fasta_dna', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_fasta_pep') && $self->o('f_dump_chain'))      	{ $pipeline_flow  = ['dump_fasta_pep', 'dump_chain'];} 
  	elsif ($self->o('f_dump_fasta_pep') && $self->o('f_dump_tsv_uniprot'))  { $pipeline_flow  = ['dump_fasta_pep', 'dump_tsv_uniprot'];} 
  	elsif ($self->o('f_dump_fasta_pep') && $self->o('f_dump_tsv_ena'))      { $pipeline_flow  = ['dump_fasta_pep', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_chain') && $self->o('f_dump_tsv_uniprot'))		{ $pipeline_flow  = ['dump_chain', 'dump_tsv_uniprot'];} 
  	elsif ($self->o('f_dump_chain') && $self->o('f_dump_tsv_ena'))			{ $pipeline_flow  = ['dump_chain', 'dump_tsv_ena'];} 
  	elsif ($self->o('f_dump_tsv_uniprot') && $self->o('f_dump_tsv_ena'))    { $pipeline_flow  = ['dump_tsv_uniprot', 'dump_tsv_ena'];} 
    #1 dump type  
    elsif ($self->o('f_dump_gtf'))     	 	{ $pipeline_flow  = ['dump_gtf']; } 
    elsif ($self->o('f_dump_gff3'))    	 	{ $pipeline_flow  = ['dump_gff3']; } 
    elsif ($self->o('f_dump_embl'))    	 	{ $pipeline_flow  = ['dump_embl']; } 
    elsif ($self->o('f_dump_genbank')) 	 	{ $pipeline_flow  = ['dump_genbank']; }
    elsif ($self->o('f_dump_fasta_dna')) 	{ $pipeline_flow  = ['dump_fasta_dna']; }
    elsif ($self->o('f_dump_fasta_pep')) 	{ $pipeline_flow  = ['dump_fasta_pep']; }
    elsif ($self->o('f_dump_chain'))   	 	{ $pipeline_flow  = ['dump_chain']; }    
    elsif ($self->o('f_dump_tsv_uniprot'))  { $pipeline_flow  = ['dump_tsv_uniprot']; }    
    elsif ($self->o('f_dump_tsv_ena'))   	{ $pipeline_flow  = ['dump_tsv_ena']; }    

    my %analyses_by_name = map {$_->{'-logic_name'} => $_} @$super_analyses;
    $self->tweak_analyses(\%analyses_by_name, $pipeline_flow);
    
    return [
      @$super_analyses,

	  ##### Toplevel Dumps -> Blast Dumps
	  { -logic_name     => 'convert_fasta',
	    -module         => 'Bio::EnsEMBL::Production::Pipeline::FASTA::BlastConverter',
	    -hive_capacity  => 50,
 	    -parameters     => { header_prefix => $self->o('blast_header_prefix'), }, 
        -flow_into      => { '1' => ['dump_vep'] },
#        -flow_into      => { '1' => ['init_dump_vep'] },
	  },

	  ##### VEP Dumps
      { -logic_name    => 'init_dump_vep',
        -module        => 'Bio::EnsEMBL::Variation::Pipeline::DumpVEP::InitDump',
        -parameters    => {
            #include_pattern => $self->o('include_pattern'),
            #exclude_pattern => $self->o('exclude_pattern'),
            #dump_servers    => $self->o('dump_servers'),
            #@common_params
        },
        #-input_ids     => [{}],
        #-rc_name       => 'default',
        -meadow_type   => 'LOCAL',
        -hive_capacity => 1,
        -flow_into     => {
          #'2' => ['dump_vep'],
          #'1' => $self->o('debug') ? [] : ['distribute_dumps'],
          #'2' => $self->o('debug') ? ['dump_vep'] : ['dump_vep', 'finish_dump'],
          #'3' => ['merge_vep'],
          #'4' => ['convert_vep'],
        },
      },

      { -logic_name    => 'create_ftpdir_vep',
        -module        => 'Bio::EnsEMBL::Hive::RunnableDB::SystemCmd',
        -parameters    => { cmd => 'mkdir -p ' . $self->o('ftpdir_vep'), },
        -input_ids      => [{}],
        #-flow_into     => { '1' => [ $vep_div ne 'bacteria' ? 'copy_tmp_to_ftp' : 'copy_tmp_to_ftp_bacteria'] },
        -flow_into     => { '1' => [ 'copy_tmp_to_ftp'] },
        -hive_capacity => -1,
        -meadow_type   => 'LOCAL',
      },

      { -logic_name    => 'copy_tmp_to_ftp',
        -module        => 'Bio::EnsEMBL::Hive::RunnableDB::SystemCmd',
        -parameters    => {
           # Wrap copy command into a loop to avoid job failures, because a *.tar.gz didn't find any files. 
           # This can happen, if an entire directory (like bacteria) comprises only of multi species databases.
           # In this case all vep files will be in subdirectories. 
           # There will be no matching files directly in the root of the temporary directory and 
           # just copying *.tar.gz would make the job fail even though this is ok.
                    		 cmd => q~
							 for vep_file in `find #tempdir_vep# -maxdepth 2 -name "*.tar.gz"`
							 do
						     	cp $vep_file #ftpdir_vep#
							 done
                   		     ~,
                    		 tempdir_vep => $self->o('tempdir_vep'),
                    		 ftpdir_vep  => $self->o('ftpdir_vep'),                   		     
               		       },
         -hive_capacity => -1,
		 -wait_for      => ['dump_vep', 'convert_fasta'],				
      },    

      { -logic_name     => 'dump_vep',
        -module         => 'Bio::EnsEMBL::Variation::Pipeline::DumpVEP::DumpVEP',
        -parameters     => {
							  eg		 		   => $self->o('eg'), 
							  eg_version 		   => $self->o('eg_version'), 
						      ensembl_cvs_root_dir => $self->o('ensembl_cvs_root_dir'),
                    		  pipeline_dir         => $self->o('tempdir_vep'),
						      perl_command		   => $self->o('perl_command'),
				              vep_command    	   => $self->o('vep_command'),
                           },
		-priority       => 1,
	    -hive_capacity  => 50, 
  	    -rc_name        => '32GB',
      },
      
#       { -logic_name    => 'copy_tmp_to_ftp_bacteria',
#	     -module        => 'EGExt::FTP::RunnableDB::CopyTmpFtpDir',
#         -parameters    => {
#                    		 temp_vep_file_dir => $self->o('temp_vep_file_dir'),
#                    		 ftp_vep_file_dir  => $self->o('ftp_vep_file_dir'),
#               		       },
#         -hive_capacity => -1,
#		 -wait_for      => ['dump_vep', 'convert_fasta'],				
#      },           

    ];
}

sub tweak_analyses {
    my $self = shift;
    my $analyses_by_name = shift;
    my $pipeline_flow    = shift;

    ## Extend this section to add 'convert_fasta' analysis if fasta dump is done
    if ($self->o('f_dump_fasta_dna') & $self->o('f_dump_fasta_pep')){
        $analyses_by_name->{'job_factory'}->{'-flow_into'} = {
                                                                '2->A' => $pipeline_flow,
                                                                'A->2' => ['convert_fasta'],
                                                              };   
    }
 
}



1;

