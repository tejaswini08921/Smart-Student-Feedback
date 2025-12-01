// ===== SMART FEEDBACK DASHBOARD JAVASCRIPT =====

document.addEventListener('DOMContentLoaded', function() {
    initializeStarRating();
    initializeFormValidation();
    initializeToastAutoHide();
    initializeTooltips();
    initializeSmoothScrolling();
});

// ===== STAR RATING SYSTEM =====
function initializeStarRating() {
    const starInputs = document.querySelectorAll('.rating-stars input[type="radio"]');
    const starLabels = document.querySelectorAll('.star-label');
    
    starLabels.forEach((label, index) => {
        label.addEventListener('click', function() {
            const rating = this.previousElementSibling.value;
            highlightStars(rating);
            validateRating();
        });
        
        label.addEventListener('mouseover', function() {
            const rating = this.previousElementSibling.value;
            previewStars(rating);
        });
    });
    
    // Add hover effect container
    const ratingContainer = document.querySelector('.rating-stars');
    if (ratingContainer) {
        ratingContainer.addEventListener('mouseleave', function() {
            const checkedInput = document.querySelector('.rating-stars input[type="radio"]:checked');
            if (checkedInput) {
                highlightStars(checkedInput.value);
            } else {
                resetStars();
            }
        });
    }
}

function highlightStars(rating) {
    const stars = document.querySelectorAll('.star-label');
    stars.forEach((star, index) => {
        if (index < 5 - rating) {
            star.style.color = '#ddd';
        } else {
            star.style.color = '#ffc107';
            star.style.transform = 'scale(1.1)';
            setTimeout(() => {
                star.style.transform = 'scale(1)';
            }, 300);
        }
    });
}

function previewStars(rating) {
    const stars = document.querySelectorAll('.star-label');
    stars.forEach((star, index) => {
        if (index < 5 - rating) {
            star.style.color = '#ddd';
        } else {
            star.style.color = '#ffc107';
        }
    });
}

function resetStars() {
    const stars = document.querySelectorAll('.star-label');
    stars.forEach(star => {
        star.style.color = '#ddd';
    });
}

// ===== FORM VALIDATION =====
function initializeFormValidation() {
    const form = document.getElementById('feedbackForm');
    if (!form) return;

    // Real-time validation
    const inputs = form.querySelectorAll('input, select, textarea');
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            validateField(this);
        });
        
        input.addEventListener('input', function() {
            clearFieldError(this);
        });
    });

    // Form submission validation
    form.addEventListener('submit', function(e) {
        if (!validateForm()) {
            e.preventDefault();
            showToast('Please fix the errors before submitting.', 'error');
            scrollToFirstError();
        }
    });
}

function validateForm() {
    let isValid = true;
    const form = document.getElementById('feedbackForm');
    const requiredFields = form.querySelectorAll('[required]');
    
    requiredFields.forEach(field => {
        if (!validateField(field)) {
            isValid = false;
        }
    });
    
    if (!validateRating()) {
        isValid = false;
    }
    
    if (!validateEmail(form.querySelector('#studentEmail'))) {
        isValid = false;
    }
    
    return isValid;
}

function validateField(field) {
    const value = field.value.trim();
    const fieldName = field.getAttribute('name');
    let isValid = true;
    
    clearFieldError(field);
    
    // Required field validation
    if (field.hasAttribute('required') && !value) {
        showFieldError(field, 'This field is required.');
        isValid = false;
    }
    
    // Email validation
    if (fieldName === 'studentEmail' && value) {
        if (!validateEmail(field)) {
            isValid = false;
        }
    }
    
    // Course and instructor selection validation
    if ((fieldName === 'courseName' || fieldName === 'instructorName') && value === '') {
        showFieldError(field, 'Please select an option.');
        isValid = false;
    }
    
    if (isValid) {
        showFieldSuccess(field);
    }
    
    return isValid;
}

function validateRating() {
    const ratingInput = document.querySelector('.rating-stars input[type="radio"]:checked');
    const ratingContainer = document.querySelector('.rating-container');
    const errorDiv = ratingContainer.querySelector('.invalid-feedback');
    
    if (!ratingInput) {
        if (errorDiv) {
            errorDiv.style.display = 'block';
        }
        return false;
    } else {
        if (errorDiv) {
            errorDiv.style.display = 'none';
        }
        return true;
    }
}

function validateEmail(emailField) {
    const email = emailField.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    if (email && !emailRegex.test(email)) {
        showFieldError(emailField, 'Please enter a valid email address.');
        return false;
    }
    
    return true;
}

function showFieldError(field, message) {
    clearFieldError(field);
    
    field.classList.add('is-invalid');
    field.classList.remove('is-valid');
    
    let errorDiv = field.parentNode.querySelector('.invalid-feedback');
    if (!errorDiv) {
        errorDiv = document.createElement('div');
        errorDiv.className = 'invalid-feedback';
        field.parentNode.appendChild(errorDiv);
    }
    errorDiv.textContent = message;
    errorDiv.style.display = 'block';
}

function showFieldSuccess(field) {
    clearFieldError(field);
    field.classList.add('is-valid');
    field.classList.remove('is-invalid');
}

function clearFieldError(field) {
    field.classList.remove('is-invalid', 'is-valid');
    const errorDiv = field.parentNode.querySelector('.invalid-feedback');
    if (errorDiv) {
        errorDiv.style.display = 'none';
    }
}

function scrollToFirstError() {
    const firstError = document.querySelector('.is-invalid');
    if (firstError) {
        firstError.scrollIntoView({ 
            behavior: 'smooth', 
            block: 'center' 
        });
        firstError.focus();
    }
}

// ===== TOAST NOTIFICATIONS =====
function initializeToastAutoHide() {
    const toasts = document.querySelectorAll('.toast.show');
    toasts.forEach(toast => {
        setTimeout(() => {
            hideToast(toast);
        }, 5000);
        
        // Add close button functionality
        const closeBtn = toast.querySelector('.btn-close');
        if (closeBtn) {
            closeBtn.addEventListener('click', () => hideToast(toast));
        }
    });
}

function showToast(message, type = 'info') {
    // Remove existing toasts
    const existingToasts = document.querySelectorAll('.toast');
    existingToasts.forEach(toast => toast.remove());
    
    const toastContainer = document.querySelector('.toast-container') || createToastContainer();
    
    const toast = document.createElement('div');
    toast.className = `toast show`;
    toast.setAttribute('role', 'alert');
    
    const bgClass = type === 'error' ? 'bg-danger' : 
                   type === 'success' ? 'bg-success' : 
                   type === 'warning' ? 'bg-warning' : 'bg-info';
    
    const icon = type === 'error' ? 'exclamation-circle' : 
                type === 'success' ? 'check-circle' : 
                type === 'warning' ? 'exclamation-triangle' : 'info-circle';
    
    toast.innerHTML = `
        <div class="toast-header ${bgClass} text-white">
            <i class="fas fa-${icon} me-2"></i>
            <strong class="me-auto">${type.charAt(0).toUpperCase() + type.slice(1)}</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">${message}</div>
    `;
    
    toastContainer.appendChild(toast);
    
    // Auto-hide after 5 seconds
    setTimeout(() => hideToast(toast), 5000);
    
    // Add close button functionality
    const closeBtn = toast.querySelector('.btn-close');
    closeBtn.addEventListener('click', () => hideToast(toast));
}

function hideToast(toast) {
    toast.style.opacity = '0';
    toast.style.transition = 'opacity 0.5s ease';
    setTimeout(() => {
        if (toast.parentNode) {
            toast.parentNode.removeChild(toast);
        }
    }, 500);
}

function createToastContainer() {
    const container = document.createElement('div');
    container.className = 'toast-container position-fixed top-0 end-0 p-3';
    document.body.appendChild(container);
    return container;
}

// ===== TOOLTIPS =====
function initializeTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

// ===== SMOOTH SCROLLING =====
function initializeSmoothScrolling() {
    const links = document.querySelectorAll('a[href^="#"]');
    links.forEach(link => {
        link.addEventListener('click', function(e) {
            const targetId = this.getAttribute('href');
            if (targetId !== '#') {
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    e.preventDefault();
                    targetElement.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            }
        });
    });
}

// ===== SEARCH ENHANCEMENT =====
function initializeSearch() {
    const searchInput = document.querySelector('input[name="search"]');
    if (searchInput) {
        let searchTimeout;
        
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                if (this.value.trim().length >= 2 || this.value.trim().length === 0) {
                    this.form.submit();
                }
            }, 500);
        });
    }
}

// ===== TABLE SORTING =====
function sortTable(columnIndex, tableId) {
    const table = document.getElementById(tableId);
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const isNumeric = !isNaN(parseFloat(rows[0].cells[columnIndex].textContent.trim()));
    
    const sortedRows = rows.sort((a, b) => {
        const aValue = a.cells[columnIndex].textContent.trim();
        const bValue = b.cells[columnIndex].textContent.trim();
        
        if (isNumeric) {
            return parseFloat(aValue) - parseFloat(bValue);
        } else {
            return aValue.localeCompare(bValue);
        }
    });
    
    // Clear existing rows
    while (tbody.firstChild) {
        tbody.removeChild(tbody.firstChild);
    }
    
    // Append sorted rows
    sortedRows.forEach(row => tbody.appendChild(row));
}

// ===== EXPORT FUNCTIONALITY =====
function exportToCSV() {
    showToast('Preparing your export...', 'info');
    
    // This would typically be handled by the ExportServlet
    // This is just a client-side notification
    setTimeout(() => {
        showToast('CSV export started successfully!', 'success');
    }, 1000);
}

// ===== RESPONSIVE HELPERS =====
function handleResize() {
    const cards = document.querySelectorAll('.card');
    const isMobile = window.innerWidth < 768;
    
    cards.forEach(card => {
        if (isMobile) {
            card.style.marginBottom = '1rem';
        } else {
            card.style.marginBottom = '';
        }
    });
}

// Initialize resize handler
window.addEventListener('resize', handleResize);
handleResize(); // Call initially

// ===== LOADING STATES =====
function setLoadingState(button, isLoading) {
    if (isLoading) {
        button.disabled = true;
        const originalText = button.innerHTML;
        button.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Processing...';
        button.setAttribute('data-original-text', originalText);
    } else {
        button.disabled = false;
        const originalText = button.getAttribute('data-original-text');
        if (originalText) {
            button.innerHTML = originalText;
        }
    }
}

// ===== FORM AUTO-SAVE =====
function initializeAutoSave() {
    const form = document.getElementById('feedbackForm');
    if (!form) return;
    
    let saveTimeout;
    const inputs = form.querySelectorAll('input, select, textarea');
    
    inputs.forEach(input => {
        input.addEventListener('input', function() {
            clearTimeout(saveTimeout);
            saveTimeout = setTimeout(() => {
                saveFormState();
            }, 1000);
        });
    });
}

function saveFormState() {
    const form = document.getElementById('feedbackForm');
    const formData = new FormData(form);
    const formState = {};
    
    for (let [key, value] of formData.entries()) {
        formState[key] = value;
    }
    
    localStorage.setItem('feedbackFormState', JSON.stringify(formState));
    console.log('Form state saved automatically');
}

function loadFormState() {
    const savedState = localStorage.getItem('feedbackFormState');
    if (savedState) {
        const formState = JSON.parse(savedState);
        const form = document.getElementById('feedbackForm');
        
        for (let key in formState) {
            const input = form.querySelector(`[name="${key}"]`);
            if (input) {
                if (input.type === 'radio') {
                    const radio = form.querySelector(`[name="${key}"][value="${formState[key]}"]`);
                    if (radio) radio.checked = true;
                } else {
                    input.value = formState[key];
                }
            }
        }
        
        // Restore star rating display
        const checkedRating = form.querySelector('input[name="rating"]:checked');
        if (checkedRating) {
            highlightStars(checkedRating.value);
        }
    }
}

// Load saved form state on page load
if (document.getElementById('feedbackForm')) {
    loadFormState();
    
    // Clear saved state on successful form submission
    document.getElementById('feedbackForm').addEventListener('submit', function() {
        localStorage.removeItem('feedbackFormState');
    });
}

console.log('Smart Feedback Dashboard JS loaded successfully!');