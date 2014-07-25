require "formula"

class CustomZipDownloadStrategy < CurlDownloadStrategy
  def stage
    begin
      with_system_path { quiet_safe_system "unzip", {:quiet_flag => "-qq"}, tarball_path }
    rescue ErrorDuringExecution
      ohai "Ignoring unzip errors"
    ensure
      chdir
    end
  end
end

class Chargemol < Formula
  homepage "http://ddec.sourceforge.net"
  url "https://downloads.sourceforge.net/project/ddec/chargemol_06_09_2014.zip", :using => CustomZipDownloadStrategy
  sha1 "4f58bf5a74b77ad6ea80bb483cac2f9a0a7b3cb5"

  depends_on :fortran

  def install
    cd "chargemol_06_09_2014/chargemol_FORTRAN_06_09_2014/sourcecode" do
      # This should match the contents of compile_serial.txt
      # parallel compile does not work for some reason
      system ENV["FC"], "-ochargemol", "-static-libgfortran", "precise.f08", "global_parameters.f08",
        "common_variable_declarations.f08", "module_quote.f08", "String_Utility.f08", "matrix_operations.f08",
        "module_read_job_control.f08", "module_read_wfx.f08", "gaussian_functions.f08",
        "charge_center_positions_and_parallelpiped.f08", "module_generate_kApoints_kBpoints_kCpoints.f08",
        "module_check_grid_spacing.f08", "module_add_missing_core_density.f08", "module_oxidation_density.f08",
        "module_initialize_atomic_densities.f08", "module_align_periodic_atoms.f08",
        "module_format_valence_and_total_cube_densities.f08", "module_format_valence_cube_density.f08",
        "module_format_xsf_densities.f08", "module_format_total_cube_density.f08",
        "module_check_noncollinear_XC_functional.f08", "module_gen_dens_grids_from_gaussian_basis_set_coeff.f08",
        "module_atomic_symbol_to_number.f08", "module_compute_dominant_atom_volumes.f08",
        "module_format_vasp_densities.f08", "module_run_valence_core_densities.f08", "module_core_iterator.f08",
        "module_local_multipole_moment_analysis.f08", "module_update_atomic_densities.f08",
        "module_valence_iterator.f08", "module_compute_center_of_mass.f08",
        "module_total_multipole_moment_analysis.f08", "module_cloud_penetration.f08",
        "module_atomic_number_to_symbol.f08", "module_generate_net_atomic_charge_file.f08", "Xi_mod.f08",
        "module_generate_spin_lookup_tables.f08", "module_fast_calculate_functions.f08",
        "module_calculate_theta_scalar.f08", "module_generate_atomic_spin_moment_file.f08",
        "module_collinear_spin_moments_iterator.f08", "module_calculate_theta_vector.f08",
        "module_noncollinear_spin_moments_iterator.f08", "module_calculate_sphere_sphere_intersection_volume.f08",
        "module_confinement_function.f08", "module_generate_effective_bond_order_file.f08",
        "module_determine_wether_pair_overlap_is_significant.f08", "module_calculate_final_EBOs.f08",
        "module_update_bond_pair_matrix.f08", "module_compute_comp_zero_atomic_valences_and_overlap_terms.f08",
        "module_initialize_bond_pair_matrix.f08", "module_compute_local_atomic_exchange_vectors.f08",
        "module_prepare_EBO_density_grids.f08", "module_statistical_EBO_coefficients.f08",
        "module_perform_EBO_analysis.f08", "chargemol.f08"
      bin.install "chargemol"
    end
    (share/"chargemol").install "chargemol_06_09_2014/atomic_densities"
  end

  def caveats; <<-EOS.undent
    Atomic densities have been installed to:
      #{share}/chargemol/atomic_densities/
    EOS
  end

  test do
    File.open("job_control.txt", "w") {|f| f.write("") }
    system "#{bin}/chargemol"
  end
end
