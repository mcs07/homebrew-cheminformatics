class Chargemol < Formula
  homepage "http://ddec.sourceforge.net"
  url "https://ddec.sourceforge.io/project/ddec/chargemol_09_26_2017.zip"
  version "09_26_2017"
  sha256 "3aec3805536d8b1f4b5b2bbbab3a20a1eff3cfa830aca24ad3d39d03eae0a95b"

  depends_on "gcc"

  def install
    cd "chargemol_FORTRAN_09_26_2017/sourcecode_linux" do
      # This should match the contents of compile_serial.txt
      # parallel compile does not work for some reason
      system "gfortran", "-ochargemol", "-static-libgfortran", "module_precision.f08", "module_global_parameters.f08", 
        "module_common_variable_declarations.f08", "module_quote.f08", "module_string_utilities.f08", 
        "module_matrix_operations.f08", "module_reshaping_functions.f08", "module_CM5_parameters.f08", 
        "module_calculate_atomic_polarizabilities_upper_bound.f08", "module_read_job_control.f08", 
        "module_read_wfx.f08", "module_gaussian_functions.f08", "module_compute_CM5.f08", 
        "module_check_atomic_reference_polarizabilities_available.f08", 
        "module_charge_center_positions_and_parallelpiped.f08", "module_generate_kApoints_kBpoints_kCpoints.f08", 
        "module_check_grid_spacing.f08", "module_add_missing_core_density.f08", "module_oxidation_density.f08", 
        "module_initialize_atomic_densities.f08", "module_align_periodic_atoms.f08", 
        "module_read_spin_density_cube_files.f08", "module_format_valence_and_total_cube_densities.f08", 
        "module_format_valence_cube_density.f08", "module_format_total_cube_density.f08", 
        "module_format_xsf_densities.f08", "module_check_noncollinear_XC_functional.f08", 
        "module_gen_dens_grids_from_gaussian_basis_set_coeff.f08", "module_atomic_symbol_to_number.f08", 
        "module_compute_dominant_atom_volumes.f08", "module_format_vasp_densities.f08", 
        "module_run_valence_core_densities.f08", "module_core_iterator.f08", 
        "module_local_multipole_moment_analysis.f08", "module_update_atomic_densities.f08", 
        "module_DDEC3_valence_iterator.f08", "module_DDEC6_valence_iterator.f08", "module_compute_center_of_mass.f08", 
        "module_total_multipole_moment_analysis.f08", "module_cloud_penetration.f08", 
        "module_atomic_number_to_symbol.f08", "module_generate_atomic_polarizability_upper_bound_file.f08", 
        "module_generate_net_atomic_charge_file.f08", "module_spin_functions.f08", 
        "module_generate_atomic_spin_moment_file.f08", "module_collinear_spin_moments_iterator.f08", 
        "module_noncollinear_spin_moments_iterator.f08", "module_generate_bond_order_file.f08", 
        "module_determine_whether_pair_overlap_is_significant.f08", "module_calculate_final_BOs.f08", 
        "module_integrate_bonding_terms.f08", "module_initialize_bond_pair_matrix.f08", 
        "module_compute_local_atomic_exchange_vectors.f08", "module_prepare_BO_density_grids.f08", 
        "module_perform_bond_order_analysis.f08", "module_compute_atomic_radial_moments.f08", 
        "module_print_overlap_populations.f08", "module_print_atomic_densities_file.f08", "chargemol.f08"
      bin.install "chargemol"
    end
    (share/"chargemol").install "atomic_densities"
  end

  def caveats; <<~EOS
    Atomic densities have been installed to:
      #{share}/chargemol/atomic_densities/
    EOS
  end

  test do
    File.open("job_control.txt", "w") {|f| f.write("") }
    system "#{bin}/chargemol"
  end
end
